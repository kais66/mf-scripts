#!/bin/bash
if [ "$1" == "10" ] || [ "$1" == "50" ] || [ "$1" == "100" ]
then 
	echo "RTT is $1"
else
	echo "wrong latency value"
	echo "****** PLEASE RE-RUN"
	exit
fi

if [ "$2" == "0" ] || [ "$2" == "0.01" ]
then 
	echo "loss is $2"
else
	echo "wrong loss value"
	echo "****** PLEASE RE-RUN"
	exit
fi

let "lat = $1 / 2"

# clean up, add latency
ssh root@node19-20 "tc qdisc del dev eth0.1002 root; \
			tc qdisc add dev eth0.1002 root netem delay ${lat}ms"
ssh root@node20-19 "tc qdisc del dev eth0.1002 root; \
			tc qdisc add dev eth0.1002 root netem delay ${lat}ms"

#clean up, add loss
ssh root@node20-19 "tc qdisc del dev wlan0 root"
ssh root@node20-20 "tc qdisc del dev wlan0 root"
if [ "$2" == "0.01" ]
then 
	# 6% in netem roughly amounts to 1% loss
	ssh root@node20-19 "tc qdisc add dev wlan0 root netem loss 6% 25%"
	ssh root@node20-20 "tc qdisc add dev wlan0 root netem loss 6% 25%"
fi




