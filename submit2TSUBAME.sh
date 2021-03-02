#!/bin/bash
set -Ceu

readonly GROUP_NAME='hp170020'
readonly WALL_TIME='24:00:00'
readonly JOB_NAME='MD simulation'
readonly exe=$1

nRuns=$(ls -1 npt_eq_*.log | wc -l)
for id in $(seq 0 $(($nRuns - 1)) ); do
    qsub -g ${GROUP_NAME} -l q_node=1 -l h_rt=${WALL_TIME} -v id=${id} -N ${JOB_NAME} ${exe}
done