FROM ubuntu:trusty
MAINTAINER Lars Kellogg-Stedman <lars@oddbit.com>

ENV SQUEEZE_VOL /srv/squeezebox
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://debian.slimdevices.com stable main" | tee -a /etc/apt/sources.list
RUN apt-get update && \
	apt-get -y --force-yes install wget faad flac sox && \
	wget --quiet -O /tmp/logitechmediaserver.deb http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/logitechmediaserver_7.7.5_all.deb && \
	dpkg -i /tmp/logitechmediaserver.deb; \
	rm -f /tmp/logitechmediaserver.deb; \
	apt-get clean

# logitech-media-server ships with embedded i386 binaries rather than
# just using package dependencies to pull in the ones appropriate for 
# the local architecture.  Because of course it does.
#
# So in order to play a variety of common music formats, we need to
# replace with embedded binaries with symlinks to the ones we installed
# earlier with apt.
RUN mkdir /usr/share/squeezeboxserver/Bin/x86_64-linux/; \
	mv /usr/share/squeezeboxserver/Bin/i386-linux/ /usr/share/squeezeboxserver/Bin/i386-linux-old; \
	ln -s x86_64-linux /usr/share/squeezeboxserver/Bin/i386-linux
RUN ln -s /usr/bin/faad /usr/share/squeezeboxserver/Bin/x86_64-linux/
RUN ln -s /usr/bin/flac /usr/share/squeezeboxserver/Bin/x86_64-linux/
RUN ln -s /usr/bin/sox /usr/share/squeezeboxserver/Bin/x86_64-linux/

VOLUME $SQUEEZE_VOL
EXPOSE 3483 3483/udp 9000 9090

COPY entrypoint.sh /entrypoint.sh
COPY start-squeezebox.sh /start-squeezebox.sh
RUN chmod 755 /entrypoint.sh /start-squeezebox.sh
ENTRYPOINT ["/entrypoint.sh"]

