#!/bin/bash

latency=$1
loss=$2
run=$3
disconn_intv=$4

# kill everything first 
ssh root@node19-19 "killall -9 cat; killall -9 tcpdump;"
ssh root@node19-20 "killall -9 click"
ssh root@node20-19 "killall -9 click"
ssh root@node20-20 "killall -9 python"

# start click router. 
echo "start click"
ssh root@node19-20 "nohup /usr/local/bin/click /root/mobilityfirst/router/click/conf/test/exprmt-4nodes/n2-4nodes.click >/dev/null 2>&1 &"
ssh root@node20-19 "nohup /usr/local/bin/click /root/mobilityfirst/router/click/conf/test/exprmt-4nodes/n3-4nodes.click >/dev/null 2>&1 &"

sleep 2

#conn_intv=10
conn_intv=3
server_ip=192.168.1.1

ssh root@10.10.20.19 "nohup /root/scripts/n3/periodicDisconnect.sh $conn_intv $disconn_intv >/dev/null 2>&1 &"
ssh root@10.10.20.20 "nohup /root/scripts/n4/periodicDisconnect.sh $conn_intv $disconn_intv >/dev/null 2>&1 &"

echo "start http" 
ssh root@node20-20 "python /root/scripts/n4/httpSequenceClient.py $conn_intv $server_ip"
#ssh root@node20-20 "nohup /root/scripts/exprmt/content_req_disconnect.sh $conn_intv $disconn_intv >/dev/null 2>&1 &"

# now experiment has finished, but disconn script might still be running. Kill them.
ssh root@10.10.20.19 "killall -9 periodicDisconnect.sh"
ssh root@10.10.20.20 "killall -9 periodicDisconnect.sh"

echo "collect data"
# retrieve log files
scp root@node20-20:/var/log/mf/http.log /home/kais/transport/results/1222/ip/stg-ip-${run}-${disconn_intv}.log
cat /home/kais/transport/results/1222/ip/stg-ip-${run}-${disconn_intv}.log >>/home/kais/transport/results/1222/ip/stg-ip-${loss}-${latency}-${disconn_intv}.log


