#!/bin/bash
#$ -S /bin/bash
#$ -cwd
. /etc/profile.d/modules.sh
module load cuda
unset OMP_NUM_THREADS
set -Ceu

GMX=/gs/hs0/hp170020/siida/gromacs-2019.1/build/bin/gmx

#Note: -extend time [ps]
$GMX convert-tpr -s npt_prod_${id}.tpr -extend 250000 -o npt_prod_${id}.tpr
$GMX mdrun -deffnm npt_prod_${id} -s npt_prod_${id}.tpr -cpi npt_prod_${id}.cpt -ntmpi 1 -ntomp 7
