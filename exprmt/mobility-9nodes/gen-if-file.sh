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

if1="eth0.${vlan1}"
if2="eth0.${vlan2}"

my_if=""
my_ip="192.168."
if [ $node_id -eq 1 ]; then 
  my_if=$if1
  my_ip=${ip}.1.1
elif [ $node_id -eq 2 ]; then 
  my_if=$if1
  my_ip=${ip}.1.2
elif [ $node_id -ge 3 -a $node_id -le 8 ]; then 
  my_if=$if2
  my_ip=${ip}.2.${node_id}
fi

echo -e "\nauto $my_if\n" >> temp_interfaces.txt
echo -e "iface $my_if inet static\n" >> temp_interfaces.txt
echo -e "  address $my_ip\n" >> temp_interfaces.txt
echo -e "  netmask 255.255.255.0\n" >> temp_interfaces.txt

if [ $node_id -eq 2 ]; then
  my_if=$if1
  my_ip=${ip}.1.2
  echo -e "\nauto $my_if\n" >> temp_interfaces.txt
  echo -e "iface $my_if inet static\n" >> temp_interfaces.txt
  echo -e "  address $my_ip\n" >> temp_interfaces.txt
  echo -e "  netmask 255.255.255.0\n" >> temp_interfaces.txt
fi
