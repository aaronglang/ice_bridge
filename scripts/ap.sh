#!/bin/sh

### delete wifi client connection
if uci show wireless | grep -o -E '\@wifi\-iface\[0\]' > /dev/null
then
    uci delete wireless.@wifi-iface[0]
    firewall=$(cat ./firewall)
    uci delete firewall."$firewall"
fi

### set access point
uci set wireless.wlan=wifi-iface
uci set wireless.wlan.device=radio0
uci set wireless.wlan.mode=ap
uci set wireless.wlan.ssid='ice-bridge'
uci set wireless.wlan.encryption=none

### commit changes
uci commit wireless

### restart
wifi

# #!/bin/sh

# ### delete wifi client connection
# if uci show wireless | grep -o -E '\@wifi\-iface\[0\]' > /dev/null
# then
#     uci delete wireless.@wifi-iface[0]
#     firewall=$(cat ./firewall)
#     uci delete firewall."$firewall"
# fi

# ### set access point
# uci set wireless.wlan=wifi-iface
# uci set wireless.wlan.device=radio0
# uci set wireless.wlan.mode=ap
# uci set wireless.wlan.ssid=Maestro
# uci set wireless.wlan.encryption=none

# ### commit changes
# uci commit wireless

# ### restart
# wifi

# wireless.radio0=wifi-device
# wireless.radio0.type=mac80211
# wireless.radio0.channel=11
# wireless.radio0.hwmode=11g
# wireless.radio0.path=10180000.wmac
# wireless.radio0.htmode=HT20

# wireless.wlan=wifi-iface
# wireless.wlan.device=radio0
# wireless.wlan.network=lan
# wireless.wlan.mode=ap
# wireless.wlan.ssid=Maestro E220
# wireless.wlan.encryption=psk-mixed
# wireless.wlan.key=W1rele$$


# wireless.radio0=wifi-device
# wireless.radio0.type=mac80211
# wireless.radio0.hwmode=11g
# wireless.radio0.path=10180000.wmac
# wireless.radio0.htmode=HT20
# wireless.radio0.disabled=0
# wireless.radio0.channel=6
# wireless.radio0.txpower=20
# wireless.radio0.country=00
# wireless.@wifi-iface[0]=wifi-iface
# wireless.@wifi-iface[0].network=wwan
# wireless.@wifi-iface[0].ssid=D031DA
# wireless.@wifi-iface[0].encryption=psk2
# wireless.@wifi-iface[0].device=radio0
# wireless.@wifi-iface[0].mode=sta
# wireless.@wifi-iface[0].bssid=58:19:F8:D0:31:DA
# wireless.@wifi-iface[0].key=82C26C2C47674
