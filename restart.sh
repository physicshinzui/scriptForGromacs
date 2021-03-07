#!/bin/bash
set -Ceu
#Like include in C
. header/path2gmx.sh
. header/restart_setting.sh
. header/error_handling.sh
. header/computing_env.sh
[ ${ENV} = 'TSUBAME' ] && . header/TSUBAME_header.sh

cat<<EOS
Author: Shinji Iida

This script makes a run restart.
Usage: 
    bash ${0} [run id] [md type (npt, ramd)]
EOS

readonly id=$1
readonly MD_TYPE=$2 #ramd or npt

#check the existence
file_exists ${MD_TYPE}_prod_${id}.tpr

#mdrub option setting
mdrun_options="-deffnm ${MD_TYPE}_prod_${id} -s ${MD_TYPE}_prod_${id}.tpr -cpi ${MD_TYPE}_prod_${id}.cpt -ntmpi ${ntmpi} -ntomp ${ntomp}" 
ramd_options=" -px ${MD_TYPE}_prod_${id}_pullx.xvg -pf ${MD_TYPE}_prod_${id}_pullf.xvg"
[ ${MD_TYPE} = 'ramd' ] && mdrun_options="${mdrun_options}${ramd_options}" #concatinate options

#Modify tpr file
$GMX convert-tpr -s ${MD_TYPE}_prod_${id}.tpr -extend ${T_EXTEND} -o ${MD_TYPE}_prod_${id}.tpr

#Restart a run
$GMX mdrun ${mdrun_options}