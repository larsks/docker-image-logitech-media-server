# Docker Container for Logitech Media Server

[![Docker Repository on Quay.io](https://quay.io/repository/jinglemansweep/logitechmediaserver/status "Docker Repository on Quay.io")](https://quay.io/repository/jinglemansweep/logitechmediaserver)

Docker image for Logitech Media Server (SqueezeCenter, SqueezeboxServer, SlimServer)

Run with:

```
docker run -d \
           -p 9000:9000 \
           -p 3483:3483 \
           -v <local-state-dir>:/mnt/state \
           -v <audio-dir>:/mnt/music \
           logitechmediaserver
```

