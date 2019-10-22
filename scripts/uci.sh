#!/bin/bash

### set wifi device enabled
uci set wireless.@wifi-device[0].disabled=0
### commit changes
uci commit wireless
### restart wifi
wifi
### commands
iface=$(uci add wireless wifi-iface)
uci batch << EOF
uci set wireless.$iface=wifi-iface
uci set wireless.$iface.network=wwan
uci set wireless.$iface.ssid='D031DA'
uci set wireless.$iface.encryption=psk2
uci set wireless.$iface.device=radio0
uci set wireless.$iface.mode=sta
uci set wireless.$iface.bssid='58:19:F8:D0:31:DA'
uci set wireless.$iface.key='82C26C2C47674'
EOF
uci commit

#  
#  /etc/configs/wireless:
#  config wifi-iface
#          option network 'wwan'
#          option ssid 'D031DA'
#          option encryption 'psk2'
#          option device 'radio0'
#          option mode 'sta'
#          option bssid '58:19:F8:D0:31:DA'
#          option key '82C26C2C47674'
#          option disabled '1'
#   
#   AP MODE
#   07:10 root@Maestro:/etc/config# uci show wireless
#   wireless.radio0=wifi-device
#   wireless.radio0.type=mac80211
#   wireless.radio0.hwmode=11g
#   wireless.radio0.path=10180000.wmac
#   wireless.radio0.htmode=HT20
#   wireless.radio0.channel=6
#   wireless.radio0.txpower=20
#   wireless.radio0.country=00
#   wireless.wlan=wifi-iface
#   wireless.wlan.device=radio0
#   wireless.wlan.mode=ap
#   wireless.wlan.ssid=Maestro
#   wireless.wlan.encryption=none
#
#   CONNECTED TO WIFI
#   07:11 root@Maestro:/etc/config# uci show wireless
#   wireless.radio0=wifi-device
#   wireless.radio0.type=mac80211
#   wireless.radio0.hwmode=11g
#   wireless.radio0.path=10180000.wmac
#   wireless.radio0.htmode=HT20
#   wireless.radio0.channel=6
#   wireless.radio0.txpower=20
#   wireless.radio0.country=00
#   wireless.radio0.disabled=0
#   wireless.@wifi-iface[0]=wifi-iface
#   wireless.@wifi-iface[0].network=wwan
#   wireless.@wifi-iface[0].ssid=D031DA
#   wireless.@wifi-iface[0].encryption=psk2
#   wireless.@wifi-iface[0].device=radio0
#   wireless.@wifi-iface[0].mode=sta
#   wireless.@wifi-iface[0].bssid=58:19:F8:D0:31:DA
#   wireless.@wifi-iface[0].key=82C26C2C47674
#
#
#
### result of uci changes after setting configs:
#
#  firewall.cfg06dc81.network=wan
#  firewall.cfg06dc81.network=wan wwan
#  firewall.cfg06dc81.network=wan
#  firewall.cfg06dc81.network=wan wwan
#  network.wwan=interface
#  network.wwan.proto=dhcp
#  wireless.radio0.disabled=0
#  wireless.cfg033579=wifi-iface
#  wireless.cfg033579.network=wwan
#  wireless.cfg033579.ssid=D031DA
#  wireless.cfg033579.encryption=psk2
#  wireless.cfg033579.device=radio0
#  wireless.cfg033579.mode=sta
#  wireless.cfg033579.bssid=58:19:F8:D0:31:DA
#  wireless.cfg033579.key=82C26C2C47674 


config redirect
    option  target      'DNAT'
    option  proto       'tcp'
    option  src         'wan'
    option  src_dport   '19900'
    option  dest        'lan'
    option  dest_port   '22'
    option  dest_ip     '192.168.1.1'
    option  name        'Allow Redirect WAN -> LAN (SSH)'

