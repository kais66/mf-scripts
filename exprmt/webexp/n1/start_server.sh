#!/bin/bash

#killall -9 mfstack
#/root/mobilityfirst/mfclient/hoststack/src/mfstack receiver_settings -d > /var/log/mf/stack.log 2> /var/log/mf/stack.log &


log_lev=f
settings_path=/root/scripts/conf/stack/sender_settings
stack_log=/var/log/mf/stack.log
proxy_log=/var/log/mf/proxy.log

killall mfstack
killall mfproxy
/root/mobilityfirst/mfclient/hoststack/src/mfstack -$log_lev $settings_path >$stack_log 2>&1 &

sleep 10
/root/mobilityfirst/mfapps/http-apps/mfproxy/mfproxy -m -P 80 -t 20 >$proxy_log 2>&1 &
#tail -f $stack_log
