#!/bin/bash
modprobe ath5k

interface=wlan1
ip=192.168.3.2
ifconfig $interface down
ifconfig $interface $ip
ifconfig $interface up
#iw $interface connect MultihomingSenderAP
iw $interface connect mf_transport
