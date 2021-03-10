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

#mdrun option setting
run_header="${MD_TYPE}_prod_${id}"
cpi_file="${MD_TYPE}_prod_${id}.cpt"
tpr_file="${MD_TYPE}_prod_${id}.tpr"
mdrun_options="-deffnm ${run_header} -s ${tpr_file} -cpi ${cpi_file} -noappend -ntmpi ${ntmpi} -ntomp ${ntomp}" 

ramd_options=" -ramd"
[ ${MD_TYPE} = 'ramd' ] && mdrun_options="${mdrun_options}${ramd_options}" #concatinate options

echo "---MD RUN options ---"
echo ${mdrun_options}

#Modify tpr file
##I found this not necessary.
#$GMX convert-tpr -s ${MD_TYPE}_prod_${id}.tpr -o ${MD_TYPE}_prod_${id}.tpr

#Restart a run
$GMX mdrun ${mdrun_options} -nsteps ${RST_N_STEPS}