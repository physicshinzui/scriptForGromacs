#!/bin/bash

echo 'NVT (templates/template_nvt.mdp)'
cat templates/template_nvt.mdp | grep -e nstep -e ref_t -e ref_p -e pcoupl | awk '{print "    " $1 " " $3 " " $4}'
echo ''
echo 'NPT (templates/template_npt.mdp)'
cat templates/template_npt.mdp | grep -e nstep -e ref_t -e ref_p -e pcoupl | awk '{print "    " $1 " " $3 " " $4}'
echo ''
echo 'NVT prod (templates/template_nvt_prod.mdp)'
cat templates/template_nvt_prod.mdp | grep -e nstep -e ref_t -e ref_p -e pcoupl | awk '{print "    " $1 " " $3 " " $4}'
echo ''
echo 'NPT proad (templates/template_npt_prod.mdp)' 
cat templates/template_npt_prod.mdp | grep -e nsteps -e ref_t -e ref_p -e pcoupl | awk '{print "    " $1 " " $3 " " $4}'
echo ''
