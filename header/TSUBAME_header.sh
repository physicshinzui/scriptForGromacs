#!/bin/bash
#$ -S /bin/bash
#$ -cwd
echo "~ TSUBAME header is active. ~"
. /etc/profile.d/modules.sh
module load cuda
unset OMP_NUM_THREADS