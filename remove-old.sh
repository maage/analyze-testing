#!/bin/sh
docker ps -q --filter=status=exited|xargs -r docker rm 
docker images -q --filter=dangling=true|xargs -r docker rmi
