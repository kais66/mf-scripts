#!/bin/bash

interface=eth0
ip=10.40.0.1

ifconfig $interface down
ifconfig $interface $ip
ifconfig $interface up
