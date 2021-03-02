#!/bin/bash
#Like include in C
. header/path2gmx.sh
. header/production_setting.sh
. header/computing_env.sh
. header/ramd_setting.sh

set -Ceu
cat << EOS
Author: Shinji Iida
This script submits RAMD runs.
    Usage:
        bash ${0} [run id] 
EOS

id=$1

if [ -e npt_eq_${id}.tpr ] ; then
    cat templates/ramd_npt.mdp                   \
        | sed -e "s!#{RAND}!${RANDOM}!g"         \
        | sed -e "s!#{NSTEPS}!${nsteps}!g"       \
        | sed -e "s!#{TEMP}!${temp}!g"           \
        | sed -e "s!#{NSTXOUT}!${nstxout}!g"     \
        | sed -e "s!#{LOGOUT}!${nstlog}!g"       \
        | sed -e "s!#{SEED}!${RANDOM}!g"         \
        | sed -e "s!#{GROUP1}!${ramd_group1}!g"  \
        | sed -e "s!#{GROUP2}!${ramd_group2}!g"  \
        > ramd_npt_prod_${id}.mdp
else
    echo "There was no previous run ${id}."
    exit 

fi

echo "NPT runs are running..."
$GMX grompp -f ramd_npt_prod_${id}.mdp  \
            -c npt_eq_${id}.gro    \
            -t npt_eq_${id}.cpt    \
            -p topol.top           \
            -n index.ndx            \
            -o ramd_npt_prod_${id}.tpr
#Note:
# - Starting coordinates can be read from trajectory with -t
#   - Only if this information is absent will the coordinates in the -c file be used.    

$GMX mdrun -deffnm ramd_npt_prod_${id} -ntmpi ${ntmpi} -ntomp ${ntomp}
