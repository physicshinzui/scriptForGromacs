#!/bin/bash
set -Ceu

cat<<EOF
Usage:
    $0 [Trj file] [top file]

    Note: Calpha fitting and RMSD calc is default.

EOF

TRJ=$1
TOP=$2
filename=$(basename $TRJ)
out=${filename%.*}
echo C-alpha C-alpha | gmx rms -f $TRJ \
                       -s ${TOP} \
                       -tu ns \
                       -o rmsd_${out}.xvg
