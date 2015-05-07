#!/bin/bash

#iperf -w 64000 -M 1300 -s
iperf -c 192.168.1.1 -w 64000 -M 1300 -t 20 -i 1
