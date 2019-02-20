#!/bin/bash

#==============Auctions====

for i in `seq 1 5`; do runsavilerow.sh -x instances/savilerow/auction/auction_dec.eprime instances/savilerow/auction/param_dec/ results/AMOdetectStAndrews/auction_${i} -sat -sat-pb-mdd  -minion-bin minion.dms -satsolver-bin glucose_release -solver-options "-rnd-seed=${i}" -run-solver; done


for i in `seq 1 5`; do runsavilerow.sh -x instances/savilerow/auction/auction_dec.eprime instances/savilerow/auction/param_dec/ results/AMOdetectStAndrews/auctionAMO_${i} -sat -sat-pb-mdd  -minion-bin minion-amo.dms -satsolver-bin glucose_release -solver-options "-rnd-seed=${i}" -amo-detect -run-solver; done

#==========MRCPSP==========
for i in `seq 1 5`; do runsavilerow.sh -x instances/savilerow/mrcpsp/mrcpsp.eprime instances/savilerow/mrcpsp/param/ results/AMOdetectStAndrews/mrcpsp_${i} -maxsat -sat-pb-mdd  -minion-bin minion.dms -satsolver-bin open-wbo_release -solver-options "-rnd-seed=${i}" -run-solver; done

for i in `seq 1 5`; do runsavilerow.sh -x instances/savilerow/mrcpsp/mrcpsp.eprime instances/savilerow/mrcpsp/param/ results/AMOdetectStAndrews/mrcpspAMO_${i} -maxsat -sat-pb-mdd  -minion-bin minion-amo.dms -satsolver-bin open-wbo_release -solver-options "-rnd-seed=${i}" -run-solver -amo-detect; done

for i in `seq 1 5`; do runsavilerow.sh -x instances/savilerow/mrcpsp/mrcpsp.eprime instances/savilerow/mrcpsp/param/ results/AMOdetectStAndrews/mrcpspEO_${i} -maxsat -sat-pb-mdd  -minion-bin minion-amo.dms -satsolver-bin open-wbo_release -solver-options "-rnd-seed=${i}" -run-solver -amo-detect2; done


#==========NSP==============
for i in `seq 1 5`; do runsavilerow.sh -x instances/savilerow/nsp/snrp.eprime instances/savilerow/nsp/param_sub_dec/ results/AMOdetectStAndrews/nsp_${i} -sat -sat-pb-mdd  -minion-bin minion.dms -satsolver-bin glucose_release -solver-options "-rnd-seed=${i}" -run-solver -sat-sum-mdd; done

for i in `seq 1 5`; do runsavilerow.sh -x instances/savilerow/nsp/snrp.eprime instances/savilerow/nsp/param_sub_dec/ results/AMOdetectStAndrews/nspAMO_${i} -sat -sat-pb-mdd  -minion-bin minion-amo.dms -satsolver-bin glucose_release -solver-options "-rnd-seed=${i}" -run-solver -sat-sum-mdd -amo-detect; done

for i in `seq 1 5`; do runsavilerow.sh -x instances/savilerow/nsp/snrp.eprime instances/savilerow/nsp/param_sub_dec/ results/AMOdetectStAndrews/nspEO_${i} -sat -sat-pb-mdd  -minion-bin minion-amo.dms -satsolver-bin glucose_release -solver-options "-rnd-seed=${i}" -run-solver -sat-sum-mdd -amo-detect2; done
