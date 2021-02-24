#!/bin/bash
set -Ceu
cat << EOS
Author: Shinji Iida 24.2.2021 
This script automates a system preparation for Gromacs.
    Usage:
        bash ${0} [PDB file]
EOS

GMX="/usr/local/bin/gmx"

inputPDBName=$1 
proteinName=`basename ${inputPDBName%.*}`

$GMX pdb2gmx -f ${inputPDBName} -o ${proteinName}_processed.gro -water tip3p

$GMX editconf -f ${proteinName}_processed.gro \
             -o ${proteinName}_newbox.gro    \
             -d 1.0                          \
             -bt dodecahedron 

$GMX solvate -cp ${proteinName}_newbox.gro \
            -cs spc216.gro                \
            -o ${proteinName}_solv.gro    \
            -p topol.top

$GMX grompp -f templates/ions.mdp \
           -c ${proteinName}_solv.gro \
           -p topol.top \
           -o ions.tpr

echo "SOL" | $GMX genion \
    -s ions.tpr \
    -o ${proteinName}_solv_ions.gro \
    -p topol.top \
    -pname NA -nname CL \
    -conc 0.1 -neutral 

echo "Energy minimisation 1 ..."
$GMX grompp -f templates/template_em1.mdp \
           -c ${proteinName}_solv_ions.gro \
           -r ${proteinName}_solv_ions.gro \
           -p topol.top \
           -o em1.tpr 
$GMX mdrun -deffnm em1 #-ntmpi 1 -ntomp 6

echo "Energy minimisation 2 ..."
$GMX grompp -f templates/template_em2.mdp \
           -c em1.gro \
           -p topol.top \
           -o em2.tpr 
$GMX mdrun -deffnm em2 #-ntmpi 1 -ntomp 6
