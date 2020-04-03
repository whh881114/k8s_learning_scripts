#!/bin/bash

# 下载官方镜像，然后加上$registy_url前缀，最后上传到本地registry仓库。

images=$1
registry_url='registry.k8s.example.com:5000'


for image in $images
do
    docker pull $image
    docker tag $image $registry_url/$image
    docker push $registry_url/$image
done