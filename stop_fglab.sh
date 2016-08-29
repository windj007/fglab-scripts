#!/bin/bash

docker rm -f fglab fglab-mongo
docker network rm fglab

IFACE="br0"
ALLOWED_SUBNET=$(ip addr show dev $IFACE | grep -oP '\d+\.\d+\.\d+\.\d+/\d+')
sudo iptables -D DOCKER -i $IFACE -p tcp --dport 5080 ! -s $ALLOWED_SUBNET -j DROP
