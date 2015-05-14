#!/bin/bash

#killall -9 mfstack
#/root/mobilityfirst/mfclient/hoststack/src/mfstack sender_settings -d > /var/log/mf/stack.log 2> /var/log/mf/stack.log &
#/root/mobilityfirst/mfapps/http-apps/mfproxy/mfproxy -p -P 80 -t 20 -s 1

log_lev=d
settings_path=/root/scripts/conf/stack/receiver_settings
stack_log=/var/log/mf/stack.log

killall mfstack
killall mfproxy
/root/mobilityfirst/mfclient/hoststack/src/mfstack -$log_lev $settings_path >$stack_log 2>&1 &
/root/mobilityfirst/mfapps/http-apps/mfproxy/mfproxy -p -P 80 -t 20 -s 1
tail -f $stack_log
