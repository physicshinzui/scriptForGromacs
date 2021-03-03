#!/bin/bash
set -Ceu
. header/equib_setting.sh
. header/production_setting.sh
. header/ramd_setting.sh

#Usage:
#   make_mdp_file [md_type (nvt, npt, ramd)] [md_stage (eq or prod)] [run id]
function make_mdp_file {
    local md_type=$1  #nvt, npt, ramd
    local md_stage=$2 #prod or eq
    local id=$3
    local template_mdp="templates/template_${md_type}_${md_stage}.mdp"
    
    [ ! -e ${template_mdp} ] && echo "${template_mdp} doesn't exit. STOP" && exit
    echo 'OK'
    cat ${template_mdp}                          \
        | sed -e "s!#{RAND}!${RANDOM}!g"         \
        | sed -e "s!#{PROD_NSTEPS}!${PROD_NSTEPS}!g"       \
        | sed -e "s!#{EQ_NSTEPS}!${EQ_NSTEPS}!g" \
        | sed -e "s!#{EQ_TEMP}!${EQ_TEMP}!g"     \
        | sed -e "s!#{PROD_TEMP}!${PROD_TEMP}!g" \
        | sed -e "s!#{PROD_NSTXOUT}!${PROD_NSTXOUT}!g"     \
        | sed -e "s!#{PROD_LOGOUT}!${PROD_NSTLOG}!g"       \
        | sed -e "s!#{SEED}!${RANDOM}!g"         \
        | sed -e "s!#{PAIR1}!${RAMD_PAIR1}!g"  \
        | sed -e "s!#{PAIR2}!${RAMD_PAIR2}!g"  \
        > ${md_type}_${md_stage}_${id}.mdp
}
