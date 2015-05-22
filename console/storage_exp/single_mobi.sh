#!/bin/bash

# before the first time this script is run, the interface-up script has to be executed.
run=$1
exp_type=$2 # "network_proactive" # or "receiver_driven"

if [ $exp_type != "network_proactive" -a $exp_type != "receiver_driven" ]; then
    echo "wrong exp type"
    exit
fi

# server: 1:node14-10; first hop router: 2:node14-11; 
# intermediate routers: 3:node15-20, 4:node15-15
# access points: 5:node16-1, 6:node15-1, 7:node14-14, 8:dummy
# client: 9:node14-7
nodes=("dummy" "14-10" "14-11" "15-20" "15-15" "16-1" "15-1" "14-14" "dummy" "14-7")

# kill everything first 
ssh root@node${nodes[1]} "killall -9 mfstack; killall -9 mfproxy;"
ssh root@node${nodes[9]} "killall -9 mfstack; killall -9 mfproxy; killall -9 python"
for (( i=2; i<=6; i++)) do
  ssh root@node${nodes[$i]} "killall -9 click"
done


script_path="/root/scripts/"
exprmt_path="${script_path}exprmt/mobility-9nodes/"

ssh root@node${nodes[9]} "nohup iwconfig wlan0 essid mf_trans_ap_1 channel 11 &"

# start click router.
for (( i=2; i<=6; i++)) do
  if [ $i -ne 4 ]; then
    ssh root@node${nodes[$i]} "nohup ${exprmt_path}n${i}/ip_access_router.sh &"
  fi
done

# before starting the stacks, need to generate setting files to run the experiment with network-proactive mode or
# receiver-driven mode
ssh root@node${nodes[9]} "cp /root/scripts/conf/stack/recv_${exp_type} /root/scripts/conf/stack/receiver_settings"
ssh root@node${nodes[5]} "cp /root/scripts/exprmt/router_${exp_type} /root/scripts/exprmt/mfrouter.settings"
    

#ssh root@node${nodes[1]} "${exprmt_path}stack_settings.sh sender $exp_type" 
#ssh root@node${nodes[9]} "${exprmt_path}stack_settings.sh receiver $exp_type" 

# start stacks
stack_log=/var/log/mf/stack.log
ssh root@node${nodes[1]} "nohup /root/mobilityfirst/mfclient/hoststack/src/mfstack -f -t ${script_path}conf/stack/sender_settings >$stack_log 2>&1 &"
ssh root@node${nodes[9]} "nohup /root/mobilityfirst/mfclient/hoststack/src/mfstack -f -t ${script_path}conf/stack/receiver_settings >$stack_log 2>&1 &"

sleep 3

# start proxy
proxy_log=/var/log/mf/proxy.log
ssh root@node${nodes[1]} "nohup /root/mobilityfirst/mfapps/http-apps/mfproxy/mfproxy -m -P 80 -t 20 >$proxy_log 2>&1 &"
ssh root@node${nodes[9]} "nohup /root/mobilityfirst/mfapps/http-apps/mfproxy/mfproxy -p -P 80 -t 20 -s 1 >$proxy_log 2>&1 &"

# allow the proxy and router to establish states
sleep 3

conn_intv=10
mobi_intv=10

server_ip=127.0.0.1
# first AP should disconnect after. Node 5...7 are APs. 
ssh root@node${nodes[5]} "nohup ${exprmt_path}n5/periodicDisconnect.sh $conn_intv 3600 >/dev/null 2>&1 &"
ssh root@node${nodes[9]} "nohup ${exprmt_path}n9/periodicDisconnect.sh $conn_intv $mobi_intv >/dev/null 2>&1 &"
ssh root@node${nodes[9]} "nohup ${exprmt_path}n9/change_ap.sh $mobi_intv 2>&1 &"

ssh root@node${nodes[9]} "python ${exprmt_path}n9/httpSequenceClient.py $conn_intv $server_ip"

# this is now handled by the script on the node.
# associate the client with another AP. After certain amount of time (emulating mobility)
#ssh root@node${nodes[9]} "nohup iwconfig wlan0 essid mf_trans_ap_2 channel 6 commit &"


# now experiment has finished, but disconn script might still be running. Kill them. 
ssh root@node${nodes[5]} "killall -9 periodicDisconnect.sh"
ssh root@node${nodes[9]} "killall -9 periodicDisconnect.sh"

# retrieve log files
scp root@node${nodes[9]}:/var/log/mf/http.log /home/kais/transport/results/0521/mobiexp-${exp_type}-${run}.log
cat /home/kais/transport/results/0521/mobiexp-${exp_type}-${run}.log >>/home/kais/transport/results/0521/mobiexp-${exp_type}-all.log

scp root@node${nodes[9]}:/var/log/mf/stack.log /home/kais/transport/results/0521/${exp_type}-${run}.stack
scp root@node${nodes[5]}:/var/log/mf/click.log /home/kais/transport/results/0521/${exp_type}-${run}.click

