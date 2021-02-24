# Scripts of Conventional Molecular Dynamics Simulation For Gromacs

## Flow
There are three scripts by which we can execute two-stage energy minimisation, NVT and NPT equilibrium simulations, 
and production runs. 

1. `bash 01_prepMD.sh [input pdb file]`
2. `bash 02_eq [run id (unsigned integer)]`
3. `bash 03_md_prod.sh [run id]`
