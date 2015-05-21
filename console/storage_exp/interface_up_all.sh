#!/bin/bash

# server: 1:node14-10; first hop router: 2:node14-11; 
# intermediate routers: 3:node15-20, 4:node15-15
# access points: 5:node16-1, 6:node15-1, 7:node14-14, 8:dummy
# client: 9:node14-7
nodes=("dummy" "14-10" "14-11" "15-20" "15-15" "16-1" "15-1" "14-14" "dummy" "14-7")
console_log=/var/log/mf/console.log

for (( i=1; i<=7; i++)) do
  ssh root@node${nodes[$i]} "cd /root/scripts/exprmt/mobility-9nodes; nohup ./setup-ifs.sh $i >$console_log 2>&1 &"
done

sleep 15
# here depending on which channel the client is using, it connects to one of the 3 APs 
ssh root@node${nodes[9]} "cd /root/scripts/exprmt/mobility-9nodes; nohup ./setup-ifs.sh 9 >$console_log 2>&1 &"
