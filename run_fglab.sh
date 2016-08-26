#!/bin/bash

docker run -d --name fglab-mongo \
    -v /opt/fglab/mongo:/data/db \
    -p 127.0.0.1:27017:27017 \
    mongo
docker run -d --name fglab \
    --link fglab-mongo:mongo \
    -p 127.0.0.1:5080:5080 \
    kaixhin/fglab
