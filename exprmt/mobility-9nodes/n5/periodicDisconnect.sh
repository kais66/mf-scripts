#!/bin/bash

connect_interval=$1
disconnect_interval=$2

tc qdisc del dev wlan0 root
sleep $connect_interval

tc qdisc add dev wlan0 root netem loss 100%
sleep $disconnect_interval

tc qdisc del dev wlan0 root
