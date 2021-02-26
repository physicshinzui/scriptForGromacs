#!/bin/bash

#Note:
#GROMACS mdrun supports OpenMP multithreading for all parts of the code. 
#OpenMP is enabled by default and can be turned on/off at configure time with the GMX_OPENMP CMake variable and
#at run-time with the -ntomp option (or the OMP_NUM_THREADS environment variable). 
#The OpenMP implementation is quite efficient and scales well for up to 12-24 threads on Intel and 6-8 threads on AMD CPUs.
#See https://manual.gromacs.org/current/user-guide/mdrun-performance.html

#my local environment
ntmpi=4 #Using 4 MPI threads
ntomp=1 #Using OpenMP 1 thread

#By default, the thread-MPI mdrun will use all available cores in the machine by starting an appropriate number of ranks 
#or OpenMP threads to occupy all of them. The number of ranks can be controlled using the -nt and -ntmpi options. 
#-nt represents the total number of threads to be used (which can be a mix of thread-MPI and OpenMP threads.