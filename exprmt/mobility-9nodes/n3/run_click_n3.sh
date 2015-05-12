#!/bin/bash
export MF_CLICK_LOG_LEVEL=1

#click_config=$MF_SRC/router/click/conf/MF_StgRouter.click
click_config=$MF_SRC/router/click/conf/MF_StgAccessMultiRouter.click
router_GUID=7
topology_file=/root/conf/topology/testcfg_5-gstar_4node_groupguid.tp
#interface=eth0
core_dev=eth0.1002
edge_dev=wlan0

gnrs_server_ip=10.14.1.8
gnrs_server_port=5001
local_ip=10.14.1.1
local_port=4001

/usr/local/bin/click -j 4 $click_config \
                     my_GUID=$router_GUID topo_file=$topology_file \
                     core_dev=$core_dev \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port \
                      edge_dev=$edge_dev
echo "/usr/local/bin/click -j 4 $click_config my_GUID=$router_GUID topo_file=$topology_file core_dev=$interface GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port"

