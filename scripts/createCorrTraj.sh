#!/bin/bash
set -Ceu

cat<<EOS

Usage:
    $0 [path to a dir including traj files (.xtc) and a reference file (.tpr) ]

Note: 
    This program accepts only the full path. 
    
EOS

readonly TRAJ_DIR="corrected_traj_data"
readonly PATH_TO_ORIG_TRAJ=$1
readonly PREFIX='npt_prod'

cat<<EOS
I'm going to create ${TRAJ_DIR}. 
Are you OK? [Enter]
EOS
read

mkdir ${TRAJ_DIR}
cd ${TRAJ_DIR}
mkdir system protein protein-h
cd system

for (( i=0; i<5; i++ )); do
    gro_corrpbc.sh ${PATH_TO_ORIG_TRAJ}/${PREFIX}_${i}.xtc ${PATH_TO_ORIG_TRAJ}/em2.tpr  1 xtc
done

cd ../../
