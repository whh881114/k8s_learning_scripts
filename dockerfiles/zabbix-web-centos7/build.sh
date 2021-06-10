#!/bin/bash

registry_url="harbor.freedom.org"
registry_project="roy"
image="$registry_url"/"$registry_project"/zabbix/zabbix-web-apache-mysql:latest

docker build -t $image .
docker push $image