#! /usr/bin/env bash

# XServer
xsock="/tmp/.X11-unix"
xauth="/tmp/.docker.xauth"

docker run --rm  \
    --name darknet \
    --user 1001:1001 \
    -it \
    --gpus all \
    -v $PWD:/workspace -w /workspace \
    --env="DISPLAY"=$DISPLAY \
    --env=XAUTHORITY=$xauth \
    --volume=$xsock:$xsock:rw \
    --volume=$xauth:$xauth:rw \
    --device=/dev/dri:/dev/dri \
    robotikainspace/moon-final:darknet  /bin/bash
