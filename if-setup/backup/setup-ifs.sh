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
ifc=wlan0


if [ "$1" -eq 1 ]; then
	ifup eth0.1001
	route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.1.2
  ethtool -K eth0.1001 tso off gso off gro off lro off
  ethtool -K eth0 tso off gso off gro off lro off
elif [ "$1" -eq 2 ]; then
  ifup eth0.1001
	ifup eth0.1002
  ethtool -K eth0.1001 tso off gso off gro off lro off
  ethtool -K eth0.1002 tso off gso off gro off lro off
  ethtool -K eth0 tso off gso off gro off lro off
elif [ "$1" -eq 3 ]; then
  ifup eth0.1002
  ethtool -K eth0.1002 tso off gso off gro off lro off
  ethtool -K eth0 tso off gso off gro off lro off
  # wifi
  AP_CONF_PATH="/root/scripts/ap/nopwd.conf"
  killall hostapd
  ifconfig $ifc down
  sleep 3
  modprobe ath5k
  sleep 3
  hostapd $AP_CONF_PATH &
  ifconfig $ifc 192.168.3.1 up
  iwconfig $ifc rate 54M

elif [ "$1" -eq 4 ]; then
  service apache2 stop
  ifconfig $ifc down
  sleep 3
  modprobe ath9k
  iwconfig $ifc mode Managed
  iwconfig $ifc essid mf_transport
  iwconfig $ifc channel 11
  ifconfig $ifc 192.168.3.2 up
  route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.3.1

elif [ "$1" -eq 5 ]; then
  service apache2 stop
  ifconfig $ifc down
  sleep 3
  modprobe ath9k
  iwconfig $ifc mode Managed
  iwconfig $ifc essid mf_transport
  iwconfig $ifc channel 6
  ifconfig $ifc 192.168.3.2 up
  route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.3.1

else
	echo "Not a valid id"
	exit
fi

echo "Interfaces ready"
