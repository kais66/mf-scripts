#!/bin/bash
sudo killall -9 click
export MF_CLICK_LOG_LEVEL=1

click_config=$MF_SRC/router/click/conf/test/MF_ChunkSender.click 
sender_GUID=1
dest_GUID=4

#topology_file=/root/chk-mngr-svn/eval/topology/testcfg_1-gstar_3node.tp 
topology_file=/root/chk-mngr-svn/eval/topology/testcfg_5-gstar_4node_groupguid.tp
interface=eth1

gnrs_server_ip=10.14.1.8
gnrs_server_port=5001
local_ip=10.14.1.1
local_port=4001
#SID computing service: 2048
service_id=2048
#encoded rate for generating chunk with computing service bit set
encoded_rate=2000

#1MB 1048576
#chk_size=59290
chk_size="59290=>73117=>51705=>57352=>68202=>76382=>86656"
chk_size_variation=0
chk_limit=10
chk_interval=1000
delay=10
pkt_size=1024
window_size=1
loss_prob=0

dest_NAs="3:";

/usr/local/bin/click -j 4 $click_config \
                     my_GUID=$sender_GUID topo_file=$topology_file \
                     core_dev=$interface \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port \
                     src_GUID=$sender_GUID \
                     dst_GUID=$dest_GUID \
                     service_id=$service_id \
                     chk_size=$chk_size \
                     chk_size_variation=$chk_size_variation \
                     chk_lmt=$chk_limit \
                     chk_intval=$chk_interval \
                     delay=$delay \
                     pkt_size=$pkt_size \
                     window_size=$window_size \
                     loss_prob=$loss_prob \
                     encoded_rate=$encoded_rate \
                     dst_NAs=$dest_NAs

