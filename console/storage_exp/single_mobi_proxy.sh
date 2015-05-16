#!/bin/bash

latency=$1
loss=$2
run=$3
disconn_intv=$4

# server: 1:node14-10; first hop router: 2:node14-11; 
# intermediate routers: 3:node15-20, 4:node15-15
# access points: 5:node16-1, 6:node15-1, 7:node14-14, 8:dummy
# client: 9:node14-7
nodes=("dummy" "14-10" "14-11" "15-20" "15-15" "16-1" "15-1" "14-14" "dummy" "14-7")

# kill everything first 
ssh root@node${nodes[1]} "killall -9 mfstack; killall -9 mfproxy;"
ssh root@node${nodes[9]} "killall -9 mfstack; killall -9 mfproxy; killall -9 python"
for (( i=2; i<=7; i++)) do
  ssh root@node${nodes[$i]} "killall -9 click"
done

for i in "${nodes[@]}"; do
  echo $i
done

# start click router. Make sure node20-19 is logging Timeouts and losses. Need to disable tail -f...
ssh root@node19-20 "nohup /root/scripts/n2/ip_access_router.sh &"
ssh root@node20-19 "nohup /root/scripts/n3/ip_access_router.sh &"

# start stacks
stack_log=/var/log/mf/stack.log
ssh root@node19-19 "nohup /root/mobilityfirst/mfclient/hoststack/src/mfstack -f -t /root/conf/stack/sender_settings >$stack_log 2>&1 &"
ssh root@node20-20 "nohup /root/mobilityfirst/mfclient/hoststack/src/mfstack -f -t /root/conf/stack/receiver_settings >$stack_log 2>&1 &"

sleep 2

# start proxy
proxy_log=/var/log/mf/proxy.log
ssh root@node19-19 "nohup /root/mobilityfirst/mfapps/http-apps/mfproxy/mfproxy -m -P 80 -t 20 >$proxy_log 2>&1 &"
ssh root@node20-20 "nohup /root/mobilityfirst/mfapps/http-apps/mfproxy/mfproxy -p -P 80 -t 20 -s 6 >$proxy_log 2>&1 &"

# allow the proxy and router to establish states
sleep 3

conn_intv=10
#conn_intv=3

server_ip=127.0.0.1
ssh root@10.10.20.19 "nohup /root/scripts/n3/periodicDisconnect.sh $conn_intv $disconn_intv >/dev/null 2>&1 &"
ssh root@10.10.20.20 "nohup /root/scripts/n4/periodicDisconnect.sh $conn_intv $disconn_intv >/dev/null 2>&1 &"
ssh root@node20-20 "python /root/scripts/n4/httpSequenceClient.py $conn_intv $server_ip"
#ssh root@node20-20 "nohup /root/scripts/exprmt/content_req_disconnect.sh $conn_intv $disconn_intv >/dev/null 2>&1 &"

# now experiment has finished, but disconn script might still be running. Kill them. 
ssh root@10.10.20.19 "killall -9 periodicDisconnect.sh"
ssh root@10.10.20.20 "killall -9 periodicDisconnect.sh"

# retrieve log files
#scp root@node20-20:/var/log/mf/http.log /home/kais/transport/results/1222/mf/stg-mf-${run}-${disconn_intv}.log
#cat /home/kais/transport/results/1222/mf/stg-mf-${run}-${disconn_intv}.log >>/home/kais/transport/results/1222/mf/stg-mf-${loss}-${latency}-${disconn_intv}.log

#scp root@node20-20:/var/log/mf/stack.log /home/kais/transport/results/1222/mf/stg-stack-${run}.stack
#scp root@node20-19:/var/log/mf/click.log /home/kais/transport/results/1222/mf/stg-stack-${run}.click

