FROM ubuntu

MAINTAINER JingleManSweep <jinglemansweep@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://debian.slimdevices.com stable main" | tee -a /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y --force-yes install logitechmediaserver

EXPOSE 3483 9000 9090

ENTRYPOINT squeezeboxserver --user root --prefsdir /mnt/state/prefs --logdir /mnt/state/logs --cachedir /mnt/state/cache


