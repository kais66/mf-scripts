#!/bin/bash

#base=/root/dataset/results
expf=/root/scripts/exprmt/webexp

#Run 6 different case (delay,error): (0,0) (0,0.01) (10,0) (10,0.01) (50,0) (50,0.01) (100,0) (100,0.01)

#Case (0,0)
delay=0
error=0

#start ip
#$expf/run_mf_loop.sh $delay $error


#Case (0,0.01)
delay=0
error="0.01"

#start ip
#$expf/run_mf_loop.sh $delay $error

#Case (10,0)
delay=10
error=0

#start ip
#$expf/run_mf_loop.sh $delay $error

#Case (10,0.01)
delay=10
error="0.01"

#start ip
#$expf/run_mf_loop.sh $delay $error


#Case (50,0)
delay=50
error="0"

#start ip
$expf/run_mf_loop.sh $delay $error


#Case (50,0.01)
delay=50
error="0.01"

#start ip
$expf/run_mf_loop.sh $delay $error


#Case (100,0)
delay=100
error="0"

#start ip
#$expf/run_mf_loop.sh $delay $error


#Case (100,0.01)
delay=100
error="0.01"

#start ip
#$expf/run_mf_loop.sh $delay $error

#Case (0,0)
delay=0
error=0

#start ip loop
#$expf/run_ip_loop.sh $delay $error

#Case (0,0.01)
delay=0
error="0.01"

#start ip loop
#$expf/run_ip_loop.sh $delay $error

#Case (10,0)
delay=10
error=0

#start ip loop
#$expf/run_ip_loop.sh $delay $error

#Case (10,0.01)
delay=10
error="0.01"

#start ip loop
#$expf/run_ip_loop.sh $delay $error

#Case (50,0)
delay=50
error="0"

#start ip loop
$expf/run_ip_loop.sh $delay $error

#Case (50,0.01)
delay=50
error="0.01"

#start ip loop
$expf/run_ip_loop.sh $delay $error

#Case (100,0)
delay=100
error="0"

#start ip loop
#$expf/run_ip_loop.sh $delay $error


#Case (100,0.01)
delay=100
error="0.01"

#start ip loop
#$expf/run_ip_loop.sh $delay $error
