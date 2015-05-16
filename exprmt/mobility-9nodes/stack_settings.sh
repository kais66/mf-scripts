#!/bin/bash

# client shoud either be 'receiver' or 'sender'
client=$1
exp_type=$2
if [ $client != "receiver" -a $client != "sender" ]; then
  echo "wrong parameter: usage: ./gen_setting.sh receiver_or_sender network_proactive_or_receiver_driven"
  exit
fi

if [ $exp_type != "network_proactive" -a $exp_type != "receiver_driven" ]; then
  echo "wrong parameter: usage: ./gen_setting.sh receiver_or_sender network_proactive_or_receiver_driven"
  exit
fi

echo "correct parameters"

cd /root/scripts/conf/stack
cp base_${client}_settings temp_${client}_settings
echo -e "TRANS_RELIABLE=true\nTRANS_CHK_COUNT_NACK_THRESH=3" >> temp_${client}_settings

# this is common: sendNACKTimeout is for the sender to purge transmitted data
echo "TRANS_SEND_NACK_TIMEOUT=1000000" >> temp_${client}_settings

long_timeout=1000000 # 1000s
short_timeout=2000 # 2s, this has to be propotional to the bandwidth

if [ $client == "receiver" -a $exp_type == "receiver_driven" ]; then
  echo "TRANS_RECV_NACK_TIMEOUT=${short_timeout}" >> temp_${client}_settings  
else
  echo "TRANS_RECV_NACK_TIMEOUT=${long_timeout}" >> temp_${client}_settings
fi

cp temp_${client}_settings ${client}_settings
