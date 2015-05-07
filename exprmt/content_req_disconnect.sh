#!/bin/bash

conn_intv=$1
disconn_intv=$2

ssh root@10.10.20.19 "nohup /root/scripts/n3/periodicDisconnect.sh $conn_intv $disconn_intv >/dev/null 2>&1 &"
/root/scripts/n4/periodicDisconnect.sh $conn_intv $disconn_intv >/dev/null 2>&1 &

python /root/scripts/n4/httpSequenceClient.py $conn_intv

#sleep 6
#python /root/scripts/n4/httpSequenceClient.py 

