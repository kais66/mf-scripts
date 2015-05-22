#!/bin/bash

# before the first time this script is run, the interface-up script has to be executed.
#latency=$1
#loss=$2
#run=$3
#disconn_intv=$4

# server: 1:node14-10; first hop router: 2:node14-11; 
# intermediate routers: 3:node15-20, 4:node15-15
# access points: 5:node16-1, 6:node15-1, 7:node14-14, 8:dummy
# client: 9:node14-7
nodes=("dummy" "14-10" "14-11" "15-20" "15-15" "16-1" "15-1" "14-14" "dummy" "14-7")


# this needs to be executed before the experiment
ssh root@node${nodes[9]} "nohup iwconfig wlan0 essid mf_trans_ap_1 channel 11 commit &"
sleep 10 
echo "connected client to AP1"

script_path="/root/scripts/"
exprmt_path="${script_path}exprmt/mobility-9nodes/"


conn_intv=10
mobi_intv=10

server_ip=127.0.0.1
# first AP should disconnect after. Node 5...7 are APs. 
ssh root@node${nodes[5]} "nohup ${exprmt_path}n5/periodicDisconnect.sh $conn_intv 3600 >/dev/null 2>&1 &"
ssh root@node${nodes[9]} "nohup ${exprmt_path}n9/periodicDisconnect.sh $conn_intv $mobi_intv >/dev/null 2>&1 &"

#ssh root@node${nodes[9]} "python ${exprmt_path}n9/httpSequenceClient.py $conn_intv $server_ip"
sleep $mobi_intv
sleep 1

# associate the client with another AP. After certain amount of time (emulating mobility)
ssh root@node${nodes[9]} "nohup iwconfig wlan0 essid mf_trans_ap_2 channel 6 commit "
sleep 2000



# now experiment has finished, but disconn script might still be running. Kill them. 
ssh root@node${nodes[5]} "killall -9 periodicDisconnect.sh"

# retrieve log files
#scp root@node20-20:/var/log/mf/http.log /home/kais/transport/results/1222/mf/stg-mf-${run}-${disconn_intv}.log
#cat /home/kais/transport/results/1222/mf/stg-mf-${run}-${disconn_intv}.log >>/home/kais/transport/results/1222/mf/stg-mf-${loss}-${latency}-${disconn_intv}.log

#scp root@node20-20:/var/log/mf/stack.log /home/kais/transport/results/1222/mf/stg-stack-${run}.stack
#scp root@node20-19:/var/log/mf/click.log /home/kais/transport/results/1222/mf/stg-stack-${run}.click

