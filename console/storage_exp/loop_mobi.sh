#!/bin/bash

run=0

#$exp_type="network_proactive"
$exp_type="receiver_driven"

while [ $run -lt 30 ]
do
  ./single_mobi_network_proactive.sh $run $exp_type
  let run=run+1
  echo "this is the $run th run"
done
