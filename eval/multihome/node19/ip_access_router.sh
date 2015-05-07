#!/bin/bash
sudo killall -9 click
export MF_CLICK_LOG_LEVEL=1

click_config=$MF_SRC/router/click/conf/MF_IPAccessMultiRouter.click
router_GUID=9
#topology_file=$MF_SRC/eval/topology/testcfg_1-gstar_3node.tp
#topology_file=/root/chk-mngr-svn/eval/topology/testcfg_5-gstar_4node_groupguid.tp
#topology_file=/root/chk-mngr-svn/eval/topology/testcfg_3_gstar_5node_multiflow.tp
topology_file=/root/chk-mngr-svn/eval/topology/testcfg_4-gstar_8node_multihome.tp
core_dev_interface=eth1
edge_dev_interface=eth0
edge_dev_interface_ip=10.41.14.9

gnrs_server_ip=10.14.1.8
gnrs_server_port=5001
local_ip=10.14.1.9
local_port=4001

/usr/local/bin/click -j 4 $click_config \
                     my_GUID=$router_GUID topo_file=$topology_file \
                     core_dev=$core_dev_interface \
                     edge_dev=$edge_dev_interface edge_dev_ip=$edge_dev_interface_ip \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port
echo "/usr/local/bin/click -j 4 $click_config my_GUID=$router_GUID topo_file=$topology_file core_dev=$core_dev_interface GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port"

