#!/bin/bash

#Usage:
#   make_mdp_file [md_type (nvt, npt, ramd)] [md_stage (eq or prod)] [run id]
function make_mdp_file {
    local md_type=$1  #nvt, npt, ramd
    local md_stage=$2 #prod or eq
    local id=$3
    local template_mdp="template/${md_type}_${md_stage}_${id}.mdp"

    cat ${template_mdp}                          \
        | sed -e "s!#{RAND}!${RANDOM}!g"         \
        | sed -e "s!#{NSTEPS}!${nsteps}!g"       \
        | sed -e "s!#{TEMP}!${temp}!g"           \
        | sed -e "s!#{NSTXOUT}!${nstxout}!g"     \
        | sed -e "s!#{LOGOUT}!${nstlog}!g"       \
        | sed -e "s!#{SEED}!${RANDOM}!g"         \
        | sed -e "s!#{GROUP1}!${ramd_group1}!g"  \
        | sed -e "s!#{GROUP2}!${ramd_group2}!g"  \
        > ${md_type}_${md_stage}_${id}.mdp
    else
        echo "There was no previous run ${id}."
        exit 
    fi
}
