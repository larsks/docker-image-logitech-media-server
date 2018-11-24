FROM ubuntu:xenial
MAINTAINER Lars Kellogg-Stedman <lars@oddbit.com>

ENV SQUEEZE_VOL /srv/squeezebox
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ARG PACKAGE_URL=http://downloads-origin.slimdevices.com/nightly/7.9/sc/81275414b6a26d6bb36898d833605b5a6d707421/logitechmediaserver_7.9.2~1542807489_all.deb

RUN apt-get update && \
	apt-get -y install \
		curl \
		wget \
		faad \
		flac \
		lame \
		sox \
		libio-socket-ssl-perl \
		tzdata \
		&& \
	apt-get clean

RUN curl -Lsf -o /tmp/lms.deb $PACKAGE_URL && \
	dpkg -i /tmp/lms.deb && \
	rm -f /tmp/lms.deb && \
	apt-get clean

# This will be created by the entrypoint script.
RUN userdel squeezeboxserver

VOLUME $SQUEEZE_VOL
EXPOSE 3483 3483/udp 9000 9090

COPY entrypoint.sh /entrypoint.sh
COPY start-squeezebox.sh /start-squeezebox.sh
RUN chmod 755 /entrypoint.sh /start-squeezebox.sh
ENTRYPOINT ["/entrypoint.sh"]