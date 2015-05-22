#!/bin/bash

run=0

#exp_type="receiver_driven"

exp_type="network_proactive"
while [ $run -lt 40 ]
do
  ./single_mobi.sh $run $exp_type
  let run=run+1
  echo "this is the $run th run"
done
