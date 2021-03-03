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
    bash ${0} [run id]
EOS

id=$1

#check the existence
file_exists npt_prod_${id}.tpr

#Modify tpr file
$GMX convert-tpr -s npt_prod_${id}.tpr \
                 -extend ${t_extend}   \
                 -o npt_prod_${id}.tpr

#Restart a run
$GMX mdrun -deffnm npt_prod_${id}  \
           -s npt_prod_${id}.tpr   \
           -cpi npt_prod_${id}.cpt \
           -ntmpi ${ntmpi} -ntomp ${ntomp}