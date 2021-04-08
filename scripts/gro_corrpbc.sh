#!/bin/bash
set -Ceu

#http://manual.gromacs.org/documentation/2018/onlinehelp/gmx-trjconv.html
#compact puts all atoms at the closest distance from the center of the box. 
#This can be useful for visualizing e.g. truncated octahedra or rhombic dodecahedra.

cat <<EOF

Usage:
    $0 [TRJ_FILE (.xtc)] [TOP_FILE (.pdb, .gro, or .tpr)] [NSKIP (integer)] [OUT_FORMAT (.pdb, .gro, .xtc)]

EOF

TRJ=$1
TOP=$2
nskips=$3
fmt=$4
bn=$(basename ${TRJ})
OUT=${bn%.*}.${fmt}

echo "INP: $TRJ"
echo "TOP: $TOP"
echo "OUT: $OUT"
#read -p "OK? [Enter]"

echo System | gmx trjconv -s $TOP \
                          -f ${TRJ} \
                          -o ${OUT} \
                          -pbc whole \
                          -skip ${nskips} \
                          -tu ns

echo Protein System | gmx trjconv -s $TOP \
                       -f ${OUT} \
                       -o ${OUT} \
                       -pbc cluster
rm \#*

echo Protein System | gmx trjconv -s $TOP \
                       -f ${OUT} \
                       -o ${OUT} \
                       -pbc mol -ur compact -center
rm \#*

echo Protein System | gmx trjconv -s ${TOP} \
                       -f ${OUT} \
                       -o ${OUT} \
                       -fit rot+trans
rm \#*
