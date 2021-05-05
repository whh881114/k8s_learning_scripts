#!/bin/bash

/usr/bin/java \
    -jar /usr/lib/jenkins/jenkins.war \
    -Djava.awt.headless=true \
    -DJENKINS_HOME=/data \
    --logfile=/data/jenkins.log \
    --webroot=/data/war \
    --httpPort=8080 \
    --debug=5 \
    --handlerCountMax=100 \
    --handlerCountMaxIdle=20