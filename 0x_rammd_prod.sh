#!/bin/bash
#Like include in C
. header/path2gmx.sh
. header/computing_env.sh
. header/input_file_creation.sh

set -Ceu
cat << EOS
Author: Shinji Iida
This script submits RAMD runs.
    Usage:
        bash ${0} [run id] 
EOS

id=$1
make_mdp_file ramd prod $id

echo "NPT runs are running..."
$GMX grompp -f ramd_prod_${id}.mdp  \
            -c npt_eq_${id}.gro    \
            -t npt_eq_${id}.cpt    \
            -p topol.top           \
            -n index.ndx            \
            -o ramd_prod_${id}.tpr
#Note:
# - Starting coordinates can be read from trajectory with -t
#   - Only if this information is absent will the coordinates in the -c file be used.    

$GMX mdrun -deffnm ramd_prod_${id} -ntmpi ${ntmpi} -ntomp ${ntomp} -noappend -ramd
