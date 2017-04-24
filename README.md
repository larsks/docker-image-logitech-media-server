# Docker Container for Logitech Media Server

This is a Docker image for running the Logitech Media Server package
(aka SqueezeboxServer).

**Note** The default port for LMS CLI (9090) is mapped to accessible through 9999 (TCP:9090 = Python).

## Run with Docker Compose

run `docker-compose up`

## Run directly
    docker run -d \
       -p 9000:9000 \
       -p 9999:9090 \
       -p 3483:3483 \
       -p 3483:3483/udp \
       -v /etc/localtime:/etc/localtime:ro \
       -v <local-state-dir>:/srv/squeezebox \
       -v <audio-dir>:/srv/music \
       larsks/logitech-media-server