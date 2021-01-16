#!/bin/bash

# 下载官方镜像，然后加上$registy_url前缀，最后上传到本地registry仓库。

images=$@
registry_url='harbor.freedom.org'

bg_colour_start="\e[44m"
bg_colour_end="\e[0m"

for image in $images
do
    echo -e "$bg_colour_start# [`date '+%F %H:%M:%S'`] Start downloading $image ...$bg_colour_end"
    docker pull $image
    docker tag $image $registry_url/$image
    echo -e "$bg_colour_start# [`date '+%F %H:%M:%S'`] Start pushing $image ...$bg_colour_end"
    docker push $registry_url/$image
    echo -e "$bg_colour_start# [`date '+%F %H:%M:%S'`] Done.$bg_colour_end"
    echo; echo
done