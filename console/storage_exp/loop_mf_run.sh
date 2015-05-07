#!/bin/bash

latency=50
loss=0
run=0

#disconn_intv=10
#disconn_intv=30
disconn_intv=180

while [ $run -lt 30 ]
do
  ./single_stg_run_mf.sh $latency $loss $run $disconn_intv
  let run=run+1
done
