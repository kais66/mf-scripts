#!/bin/bash

wlan_if=wlan0
ap=mf_trans_ap_1
chann=11
ip=192.168.3.2
ap_ip=192.168.3.1
iwconfig $wlan_if mode Managed essid $ap channel $chann 
ifconfig $wlan_if $ip up
route add -net 192.168.0.0 netmask gw $ap_ip
