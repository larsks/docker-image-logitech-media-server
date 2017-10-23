#!/bin/sh

: ${SQUEEZE_UID:=1000}
: ${SQUEEZE_GID:=1000}

groupadd -g $SQUEEZE_GID squeezeboxserver

useradd -u $SQUEEZE_UID -g $SQUEEZE_GID \
	-d /usr/share/squeezeboxserver/ \
	-c 'Logitech Media Server' \
	squeezeboxserver

if [ "$SQUEEZE_VOL" ] && [ -d "$SQUEEZE_VOL" ]; then
	for subdir in prefs logs cache; do
		mkdir -p $SQUEEZE_VOL/$subdir
	done
fi

# This has to happen every time in case our new uid/gid is different
# from what was previously used in the volume.
chown -R squeezeboxserver:squeezeboxserver $SQUEEZE_VOL

exec runuser -u squeezeboxserver -- /start-squeezebox.sh "$@"

