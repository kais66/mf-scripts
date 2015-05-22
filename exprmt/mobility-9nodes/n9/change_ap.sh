#!/bin/bash

mobi_intv=$1

sleep $mobi_intv
iwconfig wlan0 essid mf_trans_ap_2 channel 6


#iwconfig $wlan_if essid $ap channel $chann commit

