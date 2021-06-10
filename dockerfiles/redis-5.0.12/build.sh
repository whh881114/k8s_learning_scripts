#!/bin/bash

registry_url="hub.docker.com"
registry_project="whh881114"
image="$registry_url"/"$registry_project"/redis:5.0.12

docker build -t $image .
docker push $image