#!/bin/sh

myip=$( ip addr show eth0 | awk '$1 == "inet" {print $2}' | cut -f1 -d/ )
url="http://$myip:9000/"

echo ======================================================================
echo "$url"
echo ======================================================================
echo

exec squeezeboxserver \
	--prefsdir $SQUEEZE_VOL/prefs \
	--logdir $SQUEEZE_VOL/logs \
	--cachedir $SQUEEZE_VOL/cache "$@"

