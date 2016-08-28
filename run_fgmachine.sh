#!/bin/bash

HOSTNAME=$(hostname)
PORT=5081
CURDIR="$(pwd)/$(dirname $0)"

[ ! -f $CURDIR/projects.json ] && touch projects.json

docker run -d --name fgmachine \
    -h $HOSTNAME \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --net=host \
    -e FGLAB_URL=http://127.0.0.1:5080 \
    -e FGMACHINE_URL=http://$HOSTNAME:$PORT \
    -v $CURDIR/projects.json:/root/FGMachine/projects.json \
    -p 5081:$PORT \
    kaixhin/fgmachine

#    `curl -s localhost:3476/docker/cli`
