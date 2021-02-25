#!/bin/bash
set -Ceu
cat << EOS
Author: Shinji Iida 3.6.2019 
This script submits MD runs.
    Usage:
        bash ${0} [run id] 
EOS
. header/path2gmx.sh
id=$1

if [ -e npt_eq_${id}.tpr ] ; then
    cp templates/template_npt_prod.mdp npt_prod_${id}.mdp

else
    echo "There was no previous run ${id}."
    exit 

fi

echo "NPT runs are running..."
$GMX grompp -f npt_eq_${id}.mdp \
           -c nvt_eq_${id}.gro \
           -r nvt_eq_${id}.gro \
           -p topol.top  \
           -o npt_prod_${id}.tpr

$GMX mdrun -deffnm npt_prod_${id} #-ntmpi 1 -ntomp 6
