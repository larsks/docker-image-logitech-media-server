docker-logitechmediaserver
==========================

Docker image for Logitech Media Server (Squeezebox, Slim)

Run with:

docker run -d \
           -p 9000:9000 \
           -p 3483:3483 \
           -v <local-state-dir>:/mnt/state \
           -v <audio-dir>:/mnt/audio \
           logitechmediaserver


