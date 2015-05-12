#!/bin/bash

# check if node id is valid
if [ $1 -gt 9 -o $1 -lt 1 ]; then 
  echo 'wrong node id'
  exit
fi

node_id=$1
vlan1=2010
vlan2=2011

cp /etc/network/interfaces ./temp_interfaces.txt

ip="192.168."
if [
