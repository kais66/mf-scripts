#!/bin/bash

#wifi config
modprobe ath5k

wifi_interface=wlan0
wifi_ip=192.168.1.7

ifconfig $wifi_interface down
ifconfig $wifi_interface $wifi_ip
ifconfig $wifi_interface up
iw $wifi_interface connect MultihomingReceiverAP


#wimax config
modprobe i2400m_usb
wimax_interface=wmx0
wimax_ip=10.41.14.7

wimaxcu roff
wimaxcu ron
wimaxcu connect network 51

ifconfig $wimax_interface $wimax_ip mask 255.255.0.0 up

