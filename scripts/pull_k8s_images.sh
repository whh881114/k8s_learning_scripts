#!/bin/bash

k8s_versions='v1.17.17
v1.18.18
v1.19.10'

for k8s_version in $k8s_versions
do
    origin_images=`kubeadm config images list --kubernetes-version $k8s_version`

    for origin_image in $origin_images
    do
            harbor_img="harbor.freedom.org/$origin_image"
            offical_img=`echo ${origin_image#harbor.freedom.org}`
            docker pull $harbor_img
            docker tag $harbor_img $offical_img
    done
done