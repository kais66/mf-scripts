#!/bin/bash
export MF_CLICK_LOG_LEVEL=1

click_config=$MF_SRC/router/click/conf/test/MF_FileSender.click 
sender_GUID=1
dest_GUID=3
#default sid = 0, Anycast 1, MultiCast 2, Multihoming 4
sid=0
topology_file=/root/chk-mngr-svn/eval/topology/testcfg_1-gstar_3node.tp 
#topology_file=/root/chk-mngr-svn/eval/topology/testcfg_3_gstar_5node_multiflow.tp
interface=eth1

gnrs_server_ip=10.14.1.8
gnrs_server_port=5001
local_ip=10.14.1.1
local_port=4001

testfile=/root/testfile2
chk_size=1024000
delay=10
pkt_size=1024
loss_prob=0.05
window_size=2
/usr/local/bin/click -j 4 $click_config \
                     my_GUID=$sender_GUID topo_file=$topology_file \
                     core_dev=$interface \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port \
                     src_GUID=$sender_GUID \
                     dst_GUID=$dest_GUID \
                     service_id=$sid \
                     file_to_send=$testfile \
                     chk_size=$chk_size \
                     delay=$delay \
                     pkt_size=$pkt_size \
                     loss_prob=$loss_prob \
                     window_size=$window_size
echo "/usr/local/bin/click -j 4 $click_config my_GUID=$sender_GUID topo_file=$topology_file core_dev=$interface GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port src_GUID=$sender_GUID dst_GUID=$dest_GUID service_id=$sid file_to_send=$testfile chk_size=$chk_size delay=$delay pkt_size=$pkt_size loss_prob=$loss_prob"
