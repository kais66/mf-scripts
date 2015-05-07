#!/bin/bash

# before this, routers, and server (sender) stack/app should all be running.

server_log=/var/log/mfreceiver.log
# start receiving app, to request 40MB data
ssh root@10.10.20.20 "killall -9 receiver; \
      nohup /root/mobilityfirst/netapi/examples/receiver/receiver -m 7 -o 6 -s 41943040 >$server_log 2>&1 &"

# let the data flow for 15 seconds
sleep 15

# kill router
killall -9 click
sleep 5
# restart click again
/root/scripts/ip_access_router.sh


