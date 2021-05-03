#!/bin/bash

NAMESPACE=redis-cluster
PODNAME=common

# k8s版本v1.19前。
# kubectl -n $NAMESPACE exec ${PODNAME}-0 -it -- redis-cli -a "absebfz2rer@hbseylpySx6dlQczdylv" --cluster create --cluster-replicas 1 $(kubectl -n $NAMESPACE get pods -l app=$PODNAME -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')

# k8s版本v1.19。
kubectl -n $NAMESPACE exec ${PODNAME}-0 -it -- redis-cli -a "absebfz2rer@hbseylpySx6dlQczdylv" --cluster create --cluster-replicas 1 $(kubectl -n $NAMESPACE get pods -l app=$PODNAME -o jsonpath='{range.items[*]}{.status.podIP}:6379 ' | sed s/\ :6379\ $//)