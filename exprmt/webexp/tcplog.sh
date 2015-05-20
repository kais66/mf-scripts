#!/bin/bash

run=$1
delay=$2
error=$3

ep_log=/root/dataset/results/plt_$netType\_$run\_$delay\_$error.log

OUTPUT_PATH="/root/dataset/results/"
cwnd_log=${OUTPUT_PATH}cwnd_log_client_$run\_$delay\_$error.txt
svr_pcap=${OUTPUT_PATH}server_client_$run\_$delay\_$error.pcap
pcap_log=${OUTPUT_PATH}pcap_client_$run\_$delay\_$error.log

killall tcpdump
if [ -f $svr_pcap ]
then
        rm $svr_pcap
fi

tcpdump -C 2000 -W 10 -w $svr_pcap -i wlan0 > $pcap_log 2>&1 &

killall cat
modprobe -r tcp_probe
echo $(($(date +%s%N)/1000000))  > $cwnd_log 2>&1
modprobe tcp_probe port=80 full=1
cat /proc/net/tcpprobe >>$cwnd_log &
