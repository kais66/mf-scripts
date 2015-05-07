#!/bin/bash
export MF_CLICK_LOG_LEVEL=1

click_config=$MF_SRC/router/click/conf/MF_MultiRouter.click
router_GUID=4
topology_file=/root/chk-mngr-svn/eval/topology/testcfg_4-gstar_8node_multihome.tp
interface=eth1

gnrs_server_ip=10.14.1.8
gnrs_server_port=5001
local_ip=10.14.1.4
local_port=4001

/usr/local/bin/click -j 4 $click_config \
                     my_GUID=$router_GUID topo_file=$topology_file \
                     core_dev=$interface \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port> /var/log/mfclick.log 2> /var/log/mfclick.log &
echo "/usr/local/bin/click -j 4 $click_config my_GUID=$router_GUID topo_file=$topology_file core_dev=$interface GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port"

