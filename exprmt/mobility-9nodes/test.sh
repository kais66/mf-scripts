#!/bin/bash

a=3
s="hello world$(($a-2))"
echo $s

#nodes=("dummy" "node14-10" "node14-11" "node15-20" "node15-15" "node16-1" "node15-1" "node14-14" "dummy" "node14-7")
nodes=("dummy" "14-10" "14-11" "15-20" "15-15" "16-1" "15-1" "14-14" "dummy" "14-7")
for i in "${nodes[@]}"; do
  echo $i
done

echo '*************'

#for (( i=0; i<${#nodes[@]}; i++)) do
for (( i=2; i<=3; i++)) do
  echo ${nodes[$i]}
done

echo "ssh root@node${nodes[1]}"

script_path="/root/scripts/"
exprmt_path="${script_path}exprmt/mobility-9nodes/"
cat ${script_path}conf/stack/sender_settings
