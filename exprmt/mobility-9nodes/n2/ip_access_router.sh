#!/bin/bash
#export MF_CLICK_LOG_LEVEL=1
export MF_CLICK_LOG_LEVEL=4
MF_SRC=/root/mobilityfirst

click_config=$MF_SRC/router/click/conf/MF_IPAccessMultiRouter.click
router_GUID=2
topology_file=/root/scripts/conf/topology/transport_mobility_9nodes.tp

core_dev_interface=eth0.2011
edge_dev_interface=eth0.2010
edge_dev_interface_ip=192.168.1.2

gnrs_server_ip=192.168.2.3
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
