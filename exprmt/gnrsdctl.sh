#!/bin/bash

case "$1" in
start)
  echo 'kill java process'
  killall -9 java
  echo 'start gnrsd'
  java -ms128m -mx128m -Dlog4j.configuration=file:/root/conf/gnrs/log4j.xml -jar /root/gnrs/jars/gnrs-server-1.0.0-SNAPSHOT-jar-with-dependencies.jar /root/conf/gnrs/server.xml >& /root/gnrs/logs/gnrs.out &
  ;;
stop)
  echo 'stop gnrsd'
  killall -9 java
  ;;
status)
  ps -A | grep java
  ;;
clean-db)
  echo 'clean gnrs database'
  rm /root/gnrs/bdb/ -rf
  ;;
esac
