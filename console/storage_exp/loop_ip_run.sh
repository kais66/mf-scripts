#!/bin/bash

latency=50
loss=0
run=0

#disconn_intv=10
#disconn_intv=30
disconn_intv=180

# kill everything
ssh root@node19-19 "killall -9 mfstack; killall -9 mfproxy;"
ssh root@node19-20 "killall -9 click"
ssh root@node20-19 "killall -9 click"
ssh root@node20-20 "killall -9 mfstack; killall -9 mfproxy; killall -9 python"

# disable segmentation offloading
ssh root@node19-20 "ethtool -K eth0.1001 tso off gso off gro off lro off; ethtool -K eth0.1002 tso off gso off gro off lro off; ethtool -K eth0 tso off gso off gro off lro off"
ssh root@node20-19 "ethtool -K eth0.1002 tso off gso off gro off lro off; ethtool -K eth0 tso off gso off gro off lro off"

while [ $run -lt 30 ]
do
  ./single_stg_run_ip.sh $latency $loss $run $disconn_intv
  let run=run+1
done
