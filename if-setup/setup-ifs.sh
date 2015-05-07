#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: setup-ifs.sh node-id"
	exit
fi

echo "Setting up node $1"


#cp /root/if-setup/interfaces-n$1 /etc/network/interfaces
cp /root/scripts/if-setup/interfaces-n$1 /etc/network/interfaces

link1_if=eth0.1001
link2_if=eth0.1002

wlan_if=wlan0


if [ "$1" -eq 1 ]; then
	ifup $link1_if
	route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.1.2
  ethtool -K $link1_if tso off gso off gro off lro off
  ethtool -K eth0 tso off gso off gro off lro off
elif [ "$1" -eq 2 ]; then
  ifup $link1_if
	ifup $link2_if
  ethtool -K $link1_if tso off gso off gro off lro off
  ethtool -K $link2_if tso off gso off gro off lro off
  ethtool -K eth0 tso off gso off gro off lro off
elif [ "$1" -eq 3 ]; then
  ifup $link2_if
  ethtool -K $link2_if tso off gso off gro off lro off
  ethtool -K eth0 tso off gso off gro off lro off
  # wifi
  AP_CONF_PATH="/root/scripts/ap/trans_ap1.conf"
  killall hostapd
  ifconfig $wlan_if down
  sleep 3
  modprobe ath5k
  sleep 3
  hostapd $AP_CONF_PATH &
  ifconfig $wlan_if 192.168.3.1 up
  iwconfig $wlan_if rate 54M

elif [ "$1" -eq 4 ]; then
  service apache2 stop
  ifconfig $wlan_if down
  sleep 3
  modprobe ath9k
  iwconfig $wlan_if mode Managed
  iwconfig $wlan_if essid mf_trans_ap_1
  iwconfig $wlan_if channel 11
  ifconfig $wlan_if 192.168.3.2 up
  route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.3.1

elif [ "$1" -eq 5 ]; then
  # wifi
  AP_CONF_PATH="/root/scripts/ap/trans_ap2.conf"
  killall hostapd
  ifconfig $wlan_if down
  sleep 3
  modprobe ath5k
  sleep 3
  hostapd $AP_CONF_PATH &
  ifconfig $wlan_if 192.168.3.1 up
  iwconfig $wlan_if rate 54M


else
	echo "Not a valid id"
	exit
fi

echo "Interfaces ready"
