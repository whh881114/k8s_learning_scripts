#!/bin/bash

registry_url="harbor.freedom.org"
registry_project="roy"
image="$registry_url"/"$registry_project"/zabbix/zabbix-server-mysql:latest

docker build -t $image .
docker push $image