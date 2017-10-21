# Docker Container for Logitech Media Server

This is a Docker image for running the Logitech Media Server package
(aka SqueezeboxServer).

Run Directly:

    docker run -d --init \
               -p 9000:9000 \
               -p 9090:9090 \
               -p 3483:3483 \
               -p 3483:3483/udp \
               -v /etc/localtime:/etc/localtime:ro \
               -v <local-state-dir>:/srv/squeezebox \
               -v <audio-dir>:/srv/music \
               larsks/logitech-media-server


The web interface runs on port 9000.  If you also want this available
on port 80 (so you can use `http://yourserver/` without a port number
as the URL), you can add `-p 80:9000`, but you *must* also include `-p
9000:9000` because the players expect to be able to contact the server
on that port.

## Using docker-compose

I run this locally using a `docker-compose.yaml` file that looks like
this:

    version: "2.3"

    services:
      squeezebox:
        image: larsks/logitech-media-server
        ports:
          - "80:9000"
          - "9000:9000"
          - "9090:9090"
          - "3483:3483"
          - "3483:3483/udp"
        volumes:
          - /srv/music:/srv/music
          - squeezebox:/srv/squeezebox
          - /etc/localtime:/etc/localtime
        restart: always
        init: true

    volumes:
      squeezebox:

Note that the above syntax will only work with version `2.2` or `2.3`
of the compose file format, because those appear to be the only
versions that support the `init: true` keyword.
