#!/bin/bash

# 当使用hub.docker.com镜像仓库时，其镜像名字前不用加此地址。
#registry_url="hub.docker.com"

docker_id="whh881114"
image="$docker_id"/redis:5.0.12

docker build -t $image .
docker push $image