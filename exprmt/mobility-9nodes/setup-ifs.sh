#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: setup-ifs.sh node-id"
	exit
fi

echo "Setting up node $1"
node_id=$1

if [ $node_id -ne 9 ]; then 
  ./gen-if-file.sh $node_id
fi

link1_if=eth0.2010 # server side link
link2_if=eth0.2011

wlan_if=wlan0


if [ "$node_id" -eq 1 ]; then
	ifup $link1_if
elif [ "$node_id" -eq 2 ]; then
  ifup $link1_if
	ifup $link2_if
elif [ $node_id -eq 3 -o $node_id -eq 4 ]; then
	ifup $link2_if
elif [ $node_id -ge 5 -a $node_id -le 7 ]; then
  ifup $link2_if
  # wifi
  AP_CONF_PATH="/root/scripts/ap/trans_ap$(($node_id-4)).conf"
  killall hostapd
  ifconfig $wlan_if down
  sleep 3
  modprobe ath5k
  sleep 3
  hostapd $AP_CONF_PATH &
  ifconfig $wlan_if 192.168.3.1 up
  iwconfig $wlan_if rate 54M

elif [ "$node_id" -eq 9 ]; then
  service apache2 stop
  ifconfig $wlan_if down
  sleep 3
  modprobe ath9k
  iwconfig $wlan_if mode Managed
  iwconfig $wlan_if essid mf_trans_ap_1
  iwconfig $wlan_if channel 11
  ifconfig $wlan_if 192.168.3.2 up
  route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.3.1
else
	echo "Not a valid id"
	exit
fi

echo "Interfaces ready"
