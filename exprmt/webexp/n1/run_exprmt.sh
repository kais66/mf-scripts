#!/bin/bash

OUTPUT_PATH="/root/dataset/results/"
cwnd_log=${OUTPUT_PATH}cwnd_log.txt
svr_pcap=${OUTPUT_PATH}server.pcap
pcap_log=${OUTPUT_PATH}pcap.log

killall tcpdump
if [ -f $svr_pcap ]
then
        rm $svr_pcap
fi

tcpdump -C 2000 -W 10 -w $svr_pcap -i eth0.1001 >$pcap_log 2>&1 &

killall cat
modprobe -r tcp_probe
date +%s >$cwnd_log 2>&1
modprobe tcp_probe port=80 full=1
cat /proc/net/tcpprobe >>$cwnd_log &
