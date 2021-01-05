#!/bin/bash

Title="$1"
Content="$2"
TAG=`echo $Title | awk -F":" '{print $1}'`


curl 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=0f76fdf0-0944-4bdf-aaea-70e192f12cc2' \
   -H 'Content-Type: application/json' \
   -d '
  {"msgtype": "text",
    "text": {
        "content": "'"###$TAG###\n\n"''"$Content"'"
     }
  }'