FROM ubuntu:trusty
MAINTAINER Lars Kellogg-Stedman <lars@oddbit.com>

ENV SQUEEZE_VOL /srv/squeezebox
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://debian.slimdevices.com stable main" | tee -a /etc/apt/sources.list
RUN apt-get update && \
	apt-get -y --force-yes install wget && \
	wget --quiet -O /tmp/logitechmediaserver.deb http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/logitechmediaserver_7.7.5_all.deb && \
	dpkg -i /tmp/logitechmediaserver.deb; \
	rm -f /tmp/logitechmediaserver.deb; \
	apt-get clean

VOLUME $SQUEEZE_VOL
EXPOSE 3483 9000 9090

COPY entrypoint.sh /entrypoint.sh
COPY start-squeezebox.sh /start-squeezebox.sh
RUN chmod 755 /entrypoint.sh /start-squeezebox.sh
ENTRYPOINT ["/entrypoint.sh"]

