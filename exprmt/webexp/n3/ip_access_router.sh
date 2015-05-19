#!/bin/bash
export MF_CLICK_LOG_LEVEL=1
#export MF_CLICK_LOG_LEVEL=4
MF_SRC=/root/mobilityfirst

#click_config=$MF_SRC/router/click/conf/MF_IPAccessMultiRouter.click
click_config=$MF_SRC/router/click/conf/MF_StgAccessMultiRouter.click

router_GUID=2
#topology_file=$MF_SRC/eval/topology/testcfg_1-gstar_3node.tp
topology_file=/root/conf/topology/testcfg_5-gstar_4node_groupguid.tp
#topology_file=/root/chk-mngr-svn/eval/topology/testcfg_4-gstar_8node_multihome.tp
core_dev_interface=eth0.1002
edge_dev_interface=wlan0
edge_dev_interface_ip=192.168.3.1

gnrs_server_ip=192.168.2.100
gnrs_server_port=5001
local_ip=192.168.2.2
local_port=4001

click_log=/var/log/mf/click.log
/usr/local/bin/click -j 8 $click_config \
                     my_GUID=$router_GUID topo_file=$topology_file \
                     core_dev=$core_dev_interface \
                     edge_dev=$edge_dev_interface edge_dev_ip=$edge_dev_interface_ip \
                     GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port \
                     GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port >$click_log 2>&1 &
echo "/usr/local/bin/click -j 8 $click_config my_GUID=$router_GUID topo_file=$topology_file core_dev=$core_dev_interface edge_dev=$edge_dev_interface edge_dev_ip=$edge_dev_interface_ip GNRS_server_ip=$gnrs_server_ip GNRS_server_port=$gnrs_server_port GNRS_listen_ip=$local_ip GNRS_listen_port=$local_port"
#tail -f $click_log
