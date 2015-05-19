#!/bin/bash

run=$1
delay=$2
error=$3
expf=/root/scripts/exprmt/webexp
base=/root/dataset/results

echo "Starting MF Run $run delay $delay error $error"

#Start all the resources (i.e. router). Assumes all the networking setup is already ready
echo "Starting the resources"
ssh root@node19-20 "nohup /root/bin/gnrsdctl start > /dev/null 2&>/dev/null &"
ssh root@node20-19 "nohup /root/scripts/exprmt/webexp/n3/ip_access_router.sh > /dev/null 2&>/dev/null &"
ssh root@node19-20 "nohup /root/scripts/exprmt/webexp/n2/ip_access_router.sh > /dev/null 2&>/dev/null &"
ssh root@node19-19 "nohup /root/scripts/exprmt/webexp/n1/start_server.sh > /dev/null 2&>/dev/null &"
/root/scripts/exprmt/webexp/n4/start_proxy.sh
echo "Sleep 2"
sleep 2
echo "start proxies"
/root/scripts/exprmt/webexp/n4/start_proxy.sh > /dev/null 2&>/dev/null &

#introduce delay
echo "set latency"
$expf/set_latency.sh $delay $error
$expf/restore_latency.sh

#start data retrieval
echo "sleep 2"
sleep 5
echo "start web retrieval"
$expf/run_epload.sh mf $run $delay $error

#Kill all the resources (i.e. router). 
echo "Kill the resources"
ssh root@node20-19 "killall -9 click"
ssh root@node19-20 "killall -9 click; killall -9 java; /root/bin/gnrsdctl clean-db"
ssh root@node19-19 "killall -9 mfproxy; killall -9 mfstack"
killall -9 mfproxy
killall -9 mfstack

#copy over the logs from other nodes
echo "Copy over the results"
scp root@node20-19:/var/log/mf/click.log $base/click_$run\_$delay\_$error.log
cp /var/log/mf/stack.log $base/stack_$run\_$delay\_$error.log

echo "End MF Run"
echo " "
echo " "
