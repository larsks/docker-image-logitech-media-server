FROM ubuntu:precise

MAINTAINER JingleManSweep <jinglemansweep@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://debian.slimdevices.com stable main" | tee -a /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y --force-yes install logitechmediaserver

ADD ./startup.sh /startup.sh
RUN chmod u+x /startup.sh

EXPOSE 3483 9000 9090

ENTRYPOINT ["/startup.sh"]

