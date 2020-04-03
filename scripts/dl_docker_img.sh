#!/bin/bash

# 下载镜像，然后去掉$registy_url前缀。

images=$1
registry_url='registry.k8s.example.com:5000'

for image in $images
do
    docker pull $registry_url/$image
    docker tag  $registry_url/$image $image
done
