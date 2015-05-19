#!/bin/bash

delay=$1
error=$2
run=1
loops=5
expf=/root/scripts/exprmt/webexp

while [ $run -lt 5 ]
do
  $expf/run_ip_single.sh $run $delay $error
  let run=run+1
done
