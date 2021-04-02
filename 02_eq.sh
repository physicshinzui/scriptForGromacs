#!/bin/bash
set -Ceu
#Like include in C
. header/path2gmx.sh
. header/computing_env.sh
. header/input_file_creation.sh
[ ${ENV} = 'TSUBAME' ] && . header/TSUBAME_header.sh

cat << EOS
Author: Shinji Iida
This script submits MD runs.
    Usage:
        bash ${0} [run id]  
EOS

id=$1

read -p "Proceed? Enter"

echo "Making md inputs...(nvt.mdp and npt.mdp)"

make_mdp_file nvt eq $id
make_mdp_file npt eq $id

### MPI threads (-ntmpi) and OpenMP threads per tMPI thread (-ntomp) 
option_mpi="" #Default is off. Then, mdrun automatically assigns -ntmpi and -ntomp 
#option_mpi="-ntmpi ${ntmpi} -ntomp ${ntomp}"

echo "NVT equilibration runs are running..."
$GMX grompp -f nvt_eq_${id}.mdp \
           -c em2.gro \
           -r em2.gro \
           -p topol.top \
           -o nvt_eq_${id}.tpr
$GMX mdrun -deffnm nvt_eq_${id} ${option_mpi}

echo "NPT equilibration runs are running..."
$GMX grompp -f npt_eq_${id}.mdp \
           -c nvt_eq_${id}.gro \
           -r nvt_eq_${id}.gro \
           -p topol.top  \
           -o npt_eq_${id}.tpr
$GMX mdrun -deffnm npt_eq_${id} ${option_mpi}
