#!/bin/bash

docker run --name=server -d server
docker run --link server:server client curl server/hello -s
docker rm -f server
