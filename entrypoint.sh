#!/bin/sh

if [ "$SQUEEZE_VOL" ] && [ -d "$SQUEEZE_VOL" ]; then
	for subdir in prefs logs cache; do
		mkdir -p $SQUEEZE_VOL/$subdir
		chown -R squeezeboxserver:nogroup $SQUEEZE_VOL/$subdir
	done
fi

exec runuser -u squeezeboxserver -- /start-squeezebox.sh "$@"

