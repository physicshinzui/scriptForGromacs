#!/bin/bash
set -Ceu

cat<<EOS
Usage:
    bash $0 [SHELL] [MD_TYPE] [nPreRuns]
    Args:
        SHELL:
            - 03_md_prod.sh
            - 0x_ramd_prod.sh
            - restart.sh
        MD_TYPE: "npt or "ramd"
        nPreRuns: No. of the previous runs (>0)

    See: https://helpdesk.t3.gsic.titech.ac.jp/manuals/handbook.ja/jobs/
EOS

readonly GROUP_NAME='hp170020'
readonly WALL_TIME='24:00:00'
readonly JOB_NAME='cMD'
readonly exe=$1
readonly MD_TYPE=$2
readonly nPreRuns=$3
readonly priority='-5' #Default
for (( i=0; i<${nPreRuns}; i++ )); do
    echo "qsub -g ${GROUP_NAME} -p ${priority} -l q_node=1 -l h_rt=${WALL_TIME} -v id=${i} -N ${JOB_NAME} ${exe}"
#    qsub -g ${GROUP_NAME} -p ${priority} -l q_node=1 -l h_rt=${WALL_TIME} -v id=${i} -N ${JOB_NAME} ${exe}
done