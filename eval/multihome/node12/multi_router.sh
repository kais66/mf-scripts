#!/bin/bash
sudo killall -9 click
export MF_CLICK_LOG_LEVEL=1

click_config=$MF_SRC/router/click/conf/MF_MultiRouter.click
router_GUID=2
topology_file=/root/chk-mngr-svn/eval/topology/testcfg_4-gstar_8node_multihome.tp
#topology_file=/root/chk-mngr-svn/eval/topology/testcfg_1-gstar_3node.tp
#topology_file=/root/chk-mngr-svn/eval/topology/testcfg_5-gstar_4node_groupguid.tp
interface=eth1

gnrs_server_ip=10.14.1.8
gnrs_server_port=5001
local_ip=10.14.1.2
local_port=4001

/usr/local/bin/click -j 4 $click_config \
                     my_GUID=$router_GUID topo_file=$topology_file \
                     core_dev=$interface \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port>/var/log/mfclick.log 2> /var/log/mfclick.log &
echo "/usr/local/bin/click -j 4 $click_config my_GUID=$router_GUID topo_file=$topology_file core_dev=$interface GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port"

