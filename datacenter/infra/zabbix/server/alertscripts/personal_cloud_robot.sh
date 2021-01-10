#!/bin/bash

Title="$1"
Content="$2"
TAG=`echo $Title | awk -F":" '{print $1}'`


curl -k 'https://qyapi.weixin.qq.com./cgi-bin/webhook/send?key=4134b770-25dc-4242-a5c2-6f3177f6019c' \
   -H 'Content-Type: application/json' \
   -d '
  {"msgtype": "text",
    "text": {
        "content": "'"###$TAG###\n\n"''"$Content"'"
     }
  }'