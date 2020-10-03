#!/bin/bash

kubectl -n redis exec -it redis-cluster-0 -- redis-cli --cluster create --cluster-replicas 1 $(kubectl -n redis get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')