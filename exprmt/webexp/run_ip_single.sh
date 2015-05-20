#!/bin/bash

run=$1
delay=$2
error=$3
expf=/root/scripts/exprmt/webexp
base=/root/dataset/results

echo "Starting IP Run $run delay $delay error $error"

#Start all the resources (i.e. router). Assumes all the networking setup is already ready
echo "Starting the resources"
ssh root@node20-19 "nohup /root/scripts/exprmt/webexp/n3/ip_router.sh > /dev/null 2&>/dev/null &"
ssh root@node19-20 "nohup /root/scripts/exprmt/webexp/n2/ip_router.sh > /dev/null 2&>/dev/null &"

#introduce delay
echo "setting latency"
$expf/set_latency.sh $delay $error

#start tcpprobe logging
echo "Start tcprpobe"
#ssh root@node14-11 "nohup /root/scripts/n1/run_exprmt.sh  > /dev/null 2&>/dev/null &"
ssh root@node19-19 "nohup /root/scripts/exprmt/webexp/n1/run_exprmt.sh &"
$expf/tcplog.sh $run $delay $error

#start data retrieval
echo "going to sleep for 2"
sleep 2
echo "Start web retrieval"
$expf/run_epload.sh tcpip $run $delay $error

#Kill all the resources (i.e. router). 
echo "Kill all"
ssh root@node20-19 "killall -9 click"
ssh root@node19-20 "killall -9 click"
ssh root@node19-19 "killall -9 cat; killall -9 tcpdump"
killall -9 tcpdump
killall -9 cat
$expf/restore_latency.sh

#copy over the logs from other nodes
echo "Copy over the results"
scp root@node19-19:/root/dataset/results/cwnd_log.txt $base/cwnd_log_server_$run\_$delay\_$error.txt
scp root@node19-19:/root/dataset/results/server.pcap0 $base/server_server_$run\_$delay\_$error.pcap
scp root@node19-19:/root/dataset/results/pcap.log $base/pcap_server_$run\_$delay\_$error.log

echo "End IP Run"
echo " "
echo " "
