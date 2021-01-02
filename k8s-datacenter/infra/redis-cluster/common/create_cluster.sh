#!/bin/bash

NAMESPACE=production-redis-cluster
PODNAME=redis-cluster-common

kubectl -n $NAMESPACE exec ${PODNAME}-0 -it -- redis-cli --cluster create --cluster-replicas 1 $(kubectl -n $NAMESPACE get pods -l app=$PODNAME -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')