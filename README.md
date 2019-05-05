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

There is a [docker-compose.yaml][] included in this repository that
you will let you bring up a Logitech Media Server container using
`docker-compose`.  The compose file includes the following:

    volumes:
      - ${AUDIO_DIR}:/srv/music

To provide a value for `AUDIO_DIR`, create a `.env`
file that points `AUDIO_DIR` at the location of your music library,
for example:

    AUDIO_DIR=/home/USERNAME/Music

[docker-compose.yaml]: docker-compose.yaml

## Image building process

### Register QEMU binfmt_misc handlers

Register `qemu-*-static` for all supported processors (except the current one) as `binfmt_misc` handlers. You only need to do this once.

```
docker run --rm --privileged multiarch/qemu-user-static:register
```

In case you get an error message, try again with first removing all registered `binfmt_misc` handlers.

```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

### Prepare Build
To prepare the build download the required QEMU static user binaries.

```
./prepare.sh
```

### Build Docker images
Docker images for all supported platforms are built one after the other.

```
./build.sh
```

### References
- [HomeOps - Building multi-arch docker images](https://lobradov.github.io/Building-docker-multiarch-images/)
- [How to Build ARM Docker Images on Intel host](http://www.hotblackrobotics.com/en/blog/2018/01/22/docker-images-arm/)