#!/bin/bash

docker network create --driver bridge fglab

docker run -d --name fglab-mongo \
    --network=fglab \
    -v /opt/fglab/mongo:/data/db \
    mongo
docker run -d --name fglab \
    --network=fglab \
    -e "MONGODB_URI=mongodb://fglab-mongo:27017" \
    -p 127.0.0.1:5080:5080 \
    kaixhin/fglab
