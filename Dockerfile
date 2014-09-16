FROM ubuntu:precise

MAINTAINER JingleManSweep <jinglemansweep@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://debian.slimdevices.com stable main" | tee -a /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y --force-yes install supervisor logitechmediaserver
RUN mkdir -p /var/log/supervisor

COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/mnt/state"]
EXPOSE 3483 9000 9090

CMD ["/usr/bin/supervisord"]

