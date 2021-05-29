#!/bin/bash

registry_url="harbor.freedom.org"
registry_project="roy"
image="$registry_url"/"$registry_project"/zabbix-agent:4.0-centos-latest

docker build -t $image .
docker push $image