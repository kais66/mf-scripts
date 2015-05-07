#!/bin/bash

# before this, click IP routers, and iperf server (receiver) should all be running.

iperf_client_log=/var/log/iperf_sender.log
# start receiving app, to request 40MB data
ssh root@10.10.19.19 "killall -9 iperf; \
      nohup iperf -c 192.168.3.2 -n 41943040 -i 1 >$iperf_client_log 2>&1 &"

# let the data flow for 15 seconds
sleep 15

# kill router
killall -9 click
sleep 5
# restart click again
#/root/scripts/ip_access_router.sh
/usr/local/bin/click /root/mobilityfirst/router/click/conf/test/exprmt-4nodes/n3-4nodes.click &


### iperf commands for this experiment
## server, discards traffic, node20-20, Make sure both ends have default window properly set
# iperf -m -s
## client, generates traffic, node19-19
# iperf -c 192.168.3.2 -m -n 41943040 -i 1
