#!/bin/bash
# Sourced by condor_lar.sh (project.py <initsource>) before the reco2 stages.
# Writes reco2_lyseed.fcl, which the two reco2 optical detsim fcls include,
# so the LY-scaling seed is different for every job but identical between the
# scint-only and scint+Cherenkov streams of the same job number.
# Running interactively: create the file by hand, e.g.
#   echo 'physics.producers.lyscaling.Seed: 12345' > reco2_lyseed.fcl
export PROCESS
echo "physics.producers.lyscaling.Seed: $(( 1000000 + ${PROCESS:-0} ))" > reco2_lyseed.fcl
echo "wrote reco2_lyseed.fcl: $(cat reco2_lyseed.fcl)"
