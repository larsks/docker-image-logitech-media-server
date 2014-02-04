FROM debian

MAINTAINER JingleManSweep <jinglemansweep@gmail.com>

RUN echo "deb http://debian.slimdevices.com stable main" | tee -a /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y --force-yes upgrade
RUN apt-get -y --force-yes install logitechmediaserver

VOLUME ["/lms", "/storage"]

EXPOSE 9000

ENTRYPOINT squeezeboxserver --user root --prefsdir /var/lms/prefs --logdir /var/lms/logs --cachedir /var/lms/cache


