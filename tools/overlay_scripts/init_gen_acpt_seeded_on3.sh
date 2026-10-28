#!/bin/bash
# Sourced by condor_lar.sh. PROCESS may have been remapped by --procmap
# (project.py --makeup), and that reassignment is not exported, so export it
# here or the child script below would seed from the original condor number.
export PROCESS
init_gen_common_seeded.sh prodACPT_Single_Muons_cherenkov_3steel.fcl 6000
