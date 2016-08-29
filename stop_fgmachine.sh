#!/bin/bash

docker rm -f fgmachine

PORT=5081
IFACE="br0"
ALLOWED_SUBNET=$(ip addr show dev $IFACE | grep -oP '\d+\.\d+\.\d+\.\d+/\d+')
sudo iptables -I DOCKER -i $IFACE -p tcp --dport $PORT ! -s $ALLOWED_SUBNET -j DROP
