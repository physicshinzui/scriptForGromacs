#!/bin/bash
#$ -S /bin/bash
#$ -cwd
. /etc/profile.d/modules.sh
module load cuda
unset OMP_NUM_THREADS