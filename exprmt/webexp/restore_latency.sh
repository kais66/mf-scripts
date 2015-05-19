#!/bin/bash

# clean up, add latency
ssh root@node19-20 "tc qdisc del dev eth0.1002 root"
ssh root@node20-19 "tc qdisc del dev eth0.1002 root"

#clean up, add loss
ssh root@node20-19 "tc qdisc del dev wlan0 root"
tc qdisc del dev wlan0 root
