#!/bin/bash
#Like include in C
. header/path2gmx.sh
. header/production_setting.sh
. header/computing_env.sh

set -Ceu
cat << EOS
Author: Shinji Iida
This script submits MD runs.
    Usage:
        bash ${0} [run id] 
EOS

id=$1

if [ -e npt_eq_${id}.tpr ] ; then
    cat templates/template_npt_prod.mdp      \
        | sed -e "s!#{RAND}!${RANDOM}!g"     \
        | sed -e "s!#{NSTEPS}!${nsteps}!g"   \
        | sed -e "s!#{TEMP}!${temp}!g"       \
        | sed -e "s!#{NSTXOUT}!${nstxout}!g" \
        | sed -e "s!#{LOGOUT}!${nstlog}!g"   \
        > npt_prod_${id}.mdp
else
    echo "There was no previous run ${id}."
    exit 

fi

echo "NPT runs are running..."
$GMX grompp -f npt_prod_${id}.mdp  \
            -c npt_eq_${id}.gro    \
            -t npt_eq_${id}.cpt    \
            -p topol.top           \
            -o npt_prod_${id}.tpr
#Note:
# - Starting coordinates can be read from trajectory with -t
#   - Only if this information is absent will the coordinates in the -c file be used.    

$GMX mdrun -deffnm npt_prod_${id} -ntmpi ${ntmpi} -ntomp ${ntomp}
