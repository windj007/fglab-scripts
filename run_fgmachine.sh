#!/bin/bash

HOSTNAME=$(hostname)
PORT=5081
CURDIR="$(pwd)/$(dirname $0)"

[ ! -f $CURDIR/projects.json ] && touch $CURDIR/projects.json
[ ! -f $CURDIR/specs.json ] && touch $CURDIR/specs.json
[ ! -d $CURDIR/results ] && mkdir results

FGLAB_URL="http://$HOSTNAME:5080"

docker run -d --name fgmachine \
    -h $HOSTNAME \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --net=host \
    -e FGLAB_URL=$FGLAB_URL \
    -e FGMACHINE_URL=http://$HOSTNAME:$PORT \
    -v $CURDIR/projects.json:/root/FGMachine/projects.json \
    -v $CURDIR/specs.json:/root/FGMachine/specs.json \
    -v $CURDIR/results:/root/FGMachine/results \
    -p 5081:$PORT \
    kaixhin/fgmachine

IFACE="br0"
ALLOWED_SUBNET=$(ip addr show dev $IFACE | grep -oP '\d+\.\d+\.\d+\.\d+/\d+')
sudo iptables -I DOCKER -i $IFACE -p tcp --dport $PORT ! -s $ALLOWED_SUBNET -j DROP

#    `curl -s localhost:3476/docker/cli`
