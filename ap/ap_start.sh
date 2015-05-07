#!/bin/bash
AP_CONF_PATH="/root/scripts/ap/nopwd.conf"
ifc=wlan0
#log=${OUTPUT_PATH}ap_startup_log.txt

killall hostapd
# start the AP
ifconfig $ifc down
sleep 3
modprobe ath5k
sleep 3
hostapd $AP_CONF_PATH &
ifconfig $ifc 192.168.3.1 up
iwconfig $ifc rate 54M

# DHCP server
#/etc/init.d/dnsmasq restart
