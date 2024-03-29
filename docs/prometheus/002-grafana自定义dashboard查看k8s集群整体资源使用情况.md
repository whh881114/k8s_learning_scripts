# grafana自定义dashboard查看k8s集群整体资源使用情况


## 说明
- 虽然prometheus-operator中有自带cluster级别的计算资源图形，但是并不满足我的需求，所以考虑自己整理出一个界面来。


## 需求
- 查询变量需求：按主机名或者IP地址过滤。显示一台宿主机的CPU/MEM资源使用情况，需要使用变量来过滤。在prometheus管理界面上，查询集群主机清单使用查询语句为`kubelet_node_name{service="kubelet"}`
  - 在创建dashboard时，定义两个变量，`QUERY_TYPE`和`QUERY_TYPE_VALUE`。
  - `QUERY_TYPE`选用自定义类型，其值为`node,instance`，这两个值对应的就是`kubelet_node_name{service="kubelet"}`查询出来的标签。
  - `QUERY_TYPE_VALUE`先用查询类型，其值则为`kubelet_node_name{service="kubelet"}`，正则匹配则为`/$QUERY_TYPE=\"(.*?)(:10250)?\"/`，这样可匹配到主机名和IP地址了。

- 显示主机的CPU资源使用情况。
  - 根据社区Dashboard复制自己所以需要的功能，根据自己的实际情况做一些调整，https://grafana.com/grafana/dashboards/11074-node-exporter-for-prometheus-dashboard-en-v20201010/。
  - 显示CPU使用率，此时要用到rate函数，需要再加一个变量`INTERVAL`，即查询数据的颗粒度，定义其值为`30s,1m,2m,3m,5m,10m,30m,60m,1d`。
  - 显示CPU使用率，其查询语句为`(1 - avg(rate(node_cpu_seconds_total{instance=~"$QUERY_TYPE_VALUE",mode="idle"}[$INTERVAL])) by (instance)) * 100`。

- 显示主机的内存资源使用情况。
  - 内存计算规则就比较简单了，仅显示内存使用率即可，其查询语句为`(1 - (node_memory_MemAvailable_bytes{instance=~"$QUERY_TYPE_VALUE"} / (node_memory_MemTotal_bytes{instance=~"$QUERY_TYPE_VALUE"}))) * 100`。

- 显示主机上containers申请CPU的requests和limits情况。
  - `sum(kube_pod_container_resource_requests{resource="cpu",node="$QUERY_TYPE_VALUE"})`
  - `sum(kube_pod_container_resource_limits{resource="cpu",node="$QUERY_TYPE_VALUE"})`
  - `node:node_num_cpu:sum{node=~"$QUERY_TYPE_VALUE"}`

- 显示主机上containers申请内存的requests和limits情况。
  - `sum(kube_pod_container_resource_requests{resource="memory",node="$QUERY_TYPE_VALUE"})/1024/1024/1024`
  - `sum(kube_pod_container_resource_limits{resource="memory",node="$QUERY_TYPE_VALUE"})/1024/1024/1024`
  - `node_memory_MemTotal_bytes{instance=~"$QUERY_TYPE_VALUE"}/1024/1024/1024`