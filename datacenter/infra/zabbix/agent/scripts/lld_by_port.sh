#!/bin/bash

port=$1

status=$(netstat -ntl | grep -w ${port})
if [ "${status}" != '' ]; then
    echo "{\"data\":[{\"{#LLD_TCP_PORT_${port}}\":\"${port}\"}]}"
    echo "{\"data\":[{\"{#LLD_TCP_PORT_${port}}\":\"${port}\"}]}" > /tmp/lld-by-port-${port}.log
else
    echo "{\"data\":[]}"
    echo "{\"data\":[]}" > /tmp/lld-by-port-${port}.log
fi
