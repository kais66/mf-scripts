#!/bin/bash

# check if node id is valid
if [ $1 -gt 8 -o $1 -lt 1 ]; then 
  echo 'wrong node id'
  exit
fi

node_id=$1
vlan1=2010
vlan2=2011
vlan3=2012

cp /etc/network/interfaces ./temp_interfaces.txt

if1="eth0.${vlan1}"
if2="eth0.${vlan2}"
if3="eth0.${vlan3}"

my_if=""
my_ip="192.168"
if [ $node_id -eq 1 ]; then 
  my_if=$if1
  my_ip=${my_ip}.1.1
elif [ $node_id -ge 2 -a $node_id -le 8 ]; then 
  my_if=$if2
  my_ip=${my_ip}.2.${node_id}
fi

echo -e "\nauto $my_if" >> temp_interfaces.txt
echo -e "iface $my_if inet static" >> temp_interfaces.txt
echo -e "  address $my_ip" >> temp_interfaces.txt
echo -e "  netmask 255.255.255.0" >> temp_interfaces.txt

if [ $node_id -ge 2 -a $node_id -le 4 ]; then
  if [ $node_id -eq 2 ]; then 
    my_if=$if1
    my_ip=192.168.1.2
  elif [ $node_id -eq 3 -o $node_id -eq 4 ]; then
    my_if=$if3
    my_ip=192.168.4.${node_id}
  fi
  echo -e "\nauto $my_if" >> temp_interfaces.txt
  echo -e "iface $my_if inet static" >> temp_interfaces.txt
  echo -e "  address $my_ip" >> temp_interfaces.txt
  echo -e "  netmask 255.255.255.0" >> temp_interfaces.txt
  
fi

cp temp_interfaces.txt /etc/network/interfaces
