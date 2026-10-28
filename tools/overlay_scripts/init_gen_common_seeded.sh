#!/bin/sh
# As init_gen_common.sh, plus a generator seed fixed from the job number, so
# that job i of two productions throws the same CRY muons. The fcl key Seed
# takes precedence over the NuRandomService policy in ACPTtrigMCGen.
# Geant4 keeps its own randomness, which is the one difference between the
# samples besides the configuration.
MY_FCL_FILE=$1
MY_N_EVENTS=$2
MY_OUTPUT_FILE=${3:-genfile.root.local}
MY_SEED=$(( 1000000 + ${PROCESS:-0} ))

for f in local_gen.fcl local_gen_include.fcl; do
  echo "#include \"$MY_FCL_FILE\""                              > $f
  echo "physics.producers.generator.FluxCopyMethod: \"IFDH\""   >> $f
  echo "physics.producers.generator.MaxFluxFileMB: 500"         >> $f
  echo "services.IFDH: {}"                                      >> $f
  echo "physics.producers.generator.Seed: $MY_SEED"             >> $f
done
echo "gen_detail: { physics: {@table::physics} services: {@table::services} outputs: {@table::outputs} source: {@table::source} process_name: @local::process_name }" >> local_gen_include.fcl

if [ -f $MY_OUTPUT_FILE ]; then
    echo "File $MY_OUTPUT_FILE exists, so not generating again."
else
    echo "Generating with seed $MY_SEED"
    lar -c local_gen.fcl -T ./genfile_hist.root -o genfile.root.temp -n $MY_N_EVENTS
    lar -c standard_overlay_gen_SubRunPOTInEvent.fcl -s genfile.root.temp -T ./genfile_pot_hist.root -o $MY_OUTPUT_FILE -n -1
    rm genfile.root.temp
fi
