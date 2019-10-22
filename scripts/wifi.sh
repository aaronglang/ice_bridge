#!/bin/sh

#### ensure args are present
if [ ! "$@" ]; then
    echo "Please supply ssid and password"
    exit 1
fi

#### Parse SSID and PASSWORD
while (( "$#" )); do
  case "$1" in
    -s|--ssid)
      SSID=$2
      shift 2
      ;;
    -p|--password)
      PASSWORD=$2
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # bad arguments
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

if uci show wireless | grep -e 'wlan\.mode\=ap' > /dev/null
then
    uci delete wireless.wlan
fi

### set wifi/radio device enabled
uci set wireless.@wifi-device[0].disabled=0
echo 'set enabled'

### set firewall rules
zone=$(uci add firewall zone)
uci set firewall."$zone".network=wan
uci set firewall."$zone".network=wan wwan
echo 'set firewall'

### set network configs
uci set network.wwan=interface
uci set network.wwan.proto=dhcp
echo 'set network'

### set wireless
iface=$(uci add wireless wifi-iface)
uci set wireless."$iface"=wifi-iface
uci set wireless."$iface".network=wwan
uci set wireless."$iface".ssid="$SSID"
uci set wireless."$iface".encryption=psk2
uci set wireless."$iface".device=radio0
uci set wireless."$iface".mode=sta
uci set wireless."$iface".bssid='58:19:F8:D0:31:DA'
uci set wireless."$iface".key="$PASSWORD"
echo 'set wireless'

### commit changes
uci commit

### restart
wifi


: '
#!/bin/sh

#### ensure args are present
if [ ! "$@" ]; then
    echo "Please supply ssid and password"
    exit 1
fi

# get wifi interface
# iw dev | grep -e 'Interface' | tail -1 | grep -i -o -e 'wlan[0-9]'

#### Parse SSID and PASSWORD
# while (( "$@" )); do
  case "$1" in
    -s|--ssid)
      SSID=$2
      shift 2
      ;;
    -p|--password)
      PASSWORD=$2
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # bad arguments
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
# done

PASSWORD=$2
SSID=$1

echo $PASSWORD
echo $SSID

if uci show wireless | grep -e 'wlan\.mode\=ap' > /dev/null
then
    uci delete wireless.wlan
fi

### set wifi/radio device enabled
uci set wireless.@wifi-device[0].disabled=0
echo 'set enabled'

### set firewall rules
zone=$(uci add firewall zone)
uci set firewall."$zone".network=wan
uci set firewall."$zone".network=wan wwan
echo 'set firewall'

### set network configs
uci set network.wwan=interface
uci set network.wwan.proto=dhcp
echo 'set network'

### set wireless
iface=$(uci add wireless wifi-iface)
uci set wireless."$iface"=wifi-iface
uci set wireless."$iface".network=wwan
uci set wireless."$iface".ssid="$SSID"
uci set wireless."$iface".encryption=psk2
uci set wireless."$iface".device=radio0
uci set wireless."$iface".mode=sta
#uci set wireless."$iface".bssid='58:19:F8:D0:31:DA'
uci set wireless."$iface".key="$PASSWORD"
echo 'set wireless'

### commit changes
uci commit

### restart
wifi

'

# #!/bin/sh

# if uci show wireless | grep -e 'wlan\.mode\=ap' > /dev/null
# then
#     uci delete wireless.wlan
# fi

# ### set wifi/radio device enabled
# uci set wireless.@wifi-device[0].disabled=0
# echo 'set enabled'

# ### set firewall rules
# zone=$(uci add firewall zone)
# uci set firewall."$zone".network=wan
# uci set firewall."$zone".network=wan wwan
# echo 'set firewall'

# ### set network configs
# uci set network.wwan=interface
# uci set network.wwan.proto=dhcp
# echo 'set network'

# ### set wireless
# iface=$(uci add wireless wifi-iface)
# uci set wireless."$iface"=wifi-iface
# uci set wireless."$iface".network=wwan
# uci set wireless."$iface".ssid='D031DA'
# uci set wireless."$iface".encryption=psk2
# uci set wireless."$iface".device=radio0
# uci set wireless."$iface".mode=sta
# uci set wireless."$iface".bssid='58:19:F8:D0:31:DA'
# uci set wireless."$iface".key='82C26C2C47674'
# echo 'set wireless'

# ### commit changes
# uci commit

# ### restart
# wifi