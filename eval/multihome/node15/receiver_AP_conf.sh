#!/bin/bash
modprobe -r ath5k
modprobe ath5k nohwcrypt=1

interface=wlan1
ap_ip=192.168.1.5

ifconfig $interface down
hostapd -B hostapd_receiverAP.conf
ifconfig $interface $ap_ip
ifconfig $interface up
#iw wlan1 set power_save off
