#!/bin/bash

log_lev=d
settings_path=/root/conf/stack/receiver_settings
stack_log=/var/log/mf/stack.log

killall mfstack
/root/mobilityfirst/mfclient/hoststack/src/mfstack -$log_lev $settings_path >$stack_log 2>&1 &
tail -f $stack_log
