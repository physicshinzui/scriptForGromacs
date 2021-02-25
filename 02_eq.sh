#!/bin/bash
#Like include in C
. header/path2gmx.sh
. header/equib_setting.sh

set -Ceu
cat << EOS
Author: Shinji Iida
This script submits MD runs.
    Usage:
        bash ${0} [run id]  
EOS

id=$1
bash check_mdpfiles.sh
read -p "Proceed? Enter"

echo "Making md inputs...(nvt.mdp and npt.mdp)"
cat templates/template_nvt.mdp         \
    | sed -e "s!#{RAND}!${RANDOM}!g"   \
    | sed -e "s!#{NSTEPS}!${nsteps}!g" \
    | sed -e "s!#{TEMP}!${temp}!g" > nvt_eq_${id}.mdp

cat templates/template_npt.mdp         \
    | sed -e "s!#{RAND}!${RANDOM}!g"   \
    | sed -e "s!#{NSTEPS}!${nsteps}!g" \
    | sed -e "s!#{TEMP}!${temp}!g" > npt_eq_${id}.mdp

echo "NVT equilibration runs are running..."
$GMX grompp -f nvt_eq_${id}.mdp \
           -c em2.gro \
           -r em2.gro \
           -p topol.top \
           -o nvt_eq_${id}.tpr
$GMX mdrun -deffnm nvt_eq_${id} #-ntmpi 1 -ntomp 6

echo "NPT equilibration runs are running..."
$GMX grompp -f npt_eq_${id}.mdp \
           -c nvt_eq_${id}.gro \
           -r nvt_eq_${id}.gro \
           -p topol.top  \
           -o npt_eq_${id}.tpr
$GMX mdrun -deffnm npt_eq_${id} #-ntmpi 1 -ntomp 6
