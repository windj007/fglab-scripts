#!/bin/bash

docker network create --driver bridge fglab

docker run -d --name fglab-mongo \
    --network=fglab \
    -v /opt/fglab/mongo:/data/db \
    mongo
docker run -d --name fglab \
    --network=fglab \
    -e "MONGODB_URI=mongodb://fglab-mongo:27017" \
    -p 5080:5080 \
    kaixhin/fglab

IFACE="br0"
ALLOWED_SUBNET=$(ip addr show dev $IFACE | grep -oP '\d+\.\d+\.\d+\.\d+/\d+')
sudo iptables -I DOCKER -i $IFACE -p tcp --dport 5080 ! -s $ALLOWED_SUBNET -j DROP
