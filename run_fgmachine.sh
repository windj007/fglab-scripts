#!/bin/bash

HOSTNAME=$(hostname)
PORT=5081

docker run -d --name fgmachine \
    -h $HOSTNAME \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --net=host \
    `curl -s localhost:3476/docker/cli` \
    -e FGLAB_URL=http://127.0.0.1:5080 \
    -e FGMACHINE_URL=http://$HOSTNAME:$PORT \
    -p 5081:$PORT \
    kaixhin/fgmachine
