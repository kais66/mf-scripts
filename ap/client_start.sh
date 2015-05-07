
ifconfig wlan1 down
sleep 1
modprobe ath9k
echo "bring down wireless interface"
iwconfig wlan1 mode Managed
iwconfig wlan1 essid mf_transport
echo "connecting to mf_vehicular"
iwconfig wlan1 channel 11
ifconfig wlan1 192.168.3.2 up
echo "wireless interface set up"
