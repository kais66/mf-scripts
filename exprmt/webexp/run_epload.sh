#!/bin/bash

if [ "$#" -ne 4 ]; then
  echo "Usage: arg1: mf/ip, arg2: run number, arg3: delay, arg4: error probability"
  echo "e.g.: ./run_epload.sh mf 1 10 0.01"
  exit
fi

netType=$1
run=$2
delay=$3
error=$4

ep_log=/root/dataset/results/plt_$netType\_$run\_$delay\_$error.log

dep_dir=/root/dataset/depgraph/thirty-six/$netType/

echo "Starting retrieving web pages"
/root/archive/node-v0.10.12-linux-x64/bin/node /root/archive/epload/emulator/run.js \
    http $dep_dir >>$ep_log 2>&1
echo "Task completed"


