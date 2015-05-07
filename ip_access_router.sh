#!/bin/bash
export MF_CLICK_LOG_LEVEL=1

click_config=$MF_SRC/router/click/conf/MF_IPAccessMultiRouter.click
router_GUID=1
#topology_file=$MF_SRC/eval/topology/testcfg_1-gstar_3node.tp
topology_file=/root/conf/topology/testcfg_5-gstar_4node_groupguid.tp
#topology_file=/root/chk-mngr-svn/eval/topology/testcfg_4-gstar_8node_multihome.tp
core_dev_interface=eth0.1002
edge_dev_interface=eth0.1001
edge_dev_interface_ip=192.168.1.2

gnrs_server_ip=10.10.19.20
gnrs_server_port=5001
local_ip=10.10.19.20
local_port=4001

/usr/local/bin/click -j 4 $click_config \
                     my_GUID=$router_GUID topo_file=$topology_file \
                     core_dev=$core_dev_interface \
                     edge_dev=$edge_dev_interface edge_dev_ip=$edge_dev_interface_ip \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port
echo "/usr/local/bin/click -j 4 $click_config my_GUID=$router_GUID topo_file=$topology_file core_dev=$core_dev_interface edge_dev=$edge_dev_interface edge_dev_ip=$edge_dev_interface_ip GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port"
