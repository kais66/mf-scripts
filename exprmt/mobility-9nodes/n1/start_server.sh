#!/bin/bash

/root/mobilityfirst/mfclient/hoststack/src/mfstack receiver_settings -d > /var/log/mf/stack.log 2> /var/log/mf/stack.log &
/root/mobilityfirst/mfapps/http-apps/mfproxy/mfproxy -m -P 80 -t 20
