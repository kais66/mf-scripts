#!/bin/bash
export MF_CLICK_LOG_LEVEL=1

click_config=$MF_SRC/router/click/conf/test/MF_ChunkSender.click 
sender_GUID=1
dest_GUID=3

topology_file=/root/conf/topology/testcfg_1-gstar_3node.tp 
interface=eth1

gnrs_server_ip=10.14.1.8
gnrs_server_port=5001
local_ip=10.14.1.1
local_port=4001

service_id=0
#1MB 1048576
chk_size=1048576
chk_limit=1000
chk_interval=0
delay=10
pkt_size=1024
window_size=1
loss_prob=0

dest_NAs="1:27:313:";

/usr/local/bin/click -j 4 $click_config \
                     my_GUID=$sender_GUID topo_file=$topology_file \
                     core_dev=$interface \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port \
                     src_GUID=$sender_GUID \
                     dst_GUID=$dest_GUID \
                     service_id=$service_id \
                     chk_size=$chk_size \
                     chk_lmt=$chk_limit \
                     chk_intval=$chk_interval \
                     delay=$delay \
                     pkt_size=$pkt_size \
                     window_size=$window_size \
                     loss_prob=$loss_prob \
                     dst_NAs=$dest_NAs

