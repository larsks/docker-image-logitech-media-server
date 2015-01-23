#!/bin/sh

exec squeezeboxserver --user root \
	--prefsdir $SQUEEZE_VOL/prefs \
	--logdir $SQUEEZE_VOL/logs \
	--cachedir $SQUEEZE_VOL/cache
