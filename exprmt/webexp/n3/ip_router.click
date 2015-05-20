//NODE 2

// Shared IP input path and routing table
ip :: Strip(14)
    -> CheckIPHeader(INTERFACES 192.168.1.1/255.255.255.0 192.168.3.2/255.255.255.0)
    -> rt :: StaticIPLookup(
	192.168.3.1/32 0,
	192.168.2.2/32 0,
	192.168.3.2/32 1,
	192.168.1.1/32 2,
	255.255.255.255/32 0.0.0.0 0,
	0.0.0.0/32 0);

// ARP responses are copied to each ARPQuerier and the host.
arpt :: Tee(2);

// Input and output paths for eth0.1002
c0 :: Classifier(12/0806 20/0001, 12/0806 20/0002, 12/0800, -);
FromDevice(eth0.1002, SNIFFER false) -> c0;
out0 :: Queue(65536) -> todevice0 :: ToDevice(wlan0);
c0[0] -> ar0 :: ARPResponder(192.168.3.2 00:03:1d:0c:cd:aa) -> out0;
arpq0 :: ARPQuerier(192.168.3.1, 00:0b:6b:d9:d0:d5) -> out0;
c0[1] -> arpt;
arpt[0] -> [1]arpq0;
c0[2] -> Paint(1) -> ip;
c0[3] -> Print("eth0.1002 non-IP") -> Discard;

// Input and output paths for wlan
c1 :: Classifier(12/0806 20/0001, 12/0806 20/0002, 12/0800, -);
FromDevice(wlan0, SNIFFER false) -> c1;
out1 :: Queue(65536) -> todevice1 :: ToDevice(eth0.1002);
c1[0] -> ar1 :: ARPResponder(192.168.1.1 00:0b:6b:d9:d0:d5) -> out1;
arpq1 :: ARPQuerier(192.168.1.2, 00:03:1d:0c:cd:aa) -> out1;
c1[1] -> arpt;
arpt[1] -> [1]arpq1;
c1[2] -> Paint(2) -> ip;
c1[3] -> Print("wlan0 non-IP") -> Discard;

// Local delivery
rt[0] -> IPReassembler -> ping_ipc :: IPClassifier(icmp type echo, -);
ping_ipc[0] -> ICMPPingResponder -> [0]rt;
ping_ipc[1] -> Discard;

// Forwarding path for eth0.1002
rt[1] -> DropBroadcasts
    -> cp0 :: PaintTee(1)
    -> gio0 :: IPGWOptions(192.168.2.2)
    -> FixIPSrc(192.168.2.2)
    -> dt0 :: DecIPTTL
    -> fr0 :: IPFragmenter(1500)
    -> [0]arpq0;
dt0[1] -> ICMPError(192.168.2.2, timeexceeded) -> rt;
fr0[1] -> ICMPError(192.168.2.2, unreachable, needfrag) -> rt;
gio0[1] -> ICMPError(192.168.2.2, parameterproblem) -> rt;
cp0[1] -> ICMPError(192.168.2.2, redirect, host) -> rt;

// Forwarding path for wlan
rt[2] -> DropBroadcasts
    -> cp1 :: PaintTee(2)
    -> gio1 :: IPGWOptions(192.168.3.1)
    -> FixIPSrc(192.168.3.1)
    -> dt1 :: DecIPTTL
    -> fr1 :: IPFragmenter(1500)
    -> [0]arpq1;
dt1[1] -> ICMPError(192.168.3.1, timeexceeded) -> rt;
fr1[1] -> ICMPError(192.168.3.1, unreachable, needfrag) -> rt;
gio1[1] -> ICMPError(192.168.3.1, parameterproblem) -> rt;
cp1[1] -> ICMPError(192.168.3.1, redirect, host) -> rt;
