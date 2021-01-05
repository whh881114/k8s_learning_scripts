# k8s学习之旅

## 更新日期：2021/01/05
## 目录说明
- `docs`，文档目录，用于记录各种安装记录及实验细节。

- `platform`，用于安装k8s平台相关的软件。
    - `flannel`，k8s网络组件。
    - `ingress`，七层负载均衡。  
    - `rancher`，安装k8s管理界面，这个装好了，只是方便管理提升效率，如果不用rancher，完全是可以用kubectl及书写yml文件来完成。

- `datacenter`，模拟数据中心，用于部署业务目录。
    - `storage-class`，动态存储卷，各个目录下的子目录，表示各个存储下针对不同的应用起的不同的提供者。
        - `storage-class-cephfs`
        - `storage-class-nfs`
        - `storage-class-rbd`
        
    - `infra`，基础设施，存放共用的系统。
        - `consul`，在k8s集群中部署两个数据中心，一个是`k8s`，另一个是`vm`。`k8s`用于k8s集群中的主机加入，`vm`则用于虚拟机加入到此集群；此外，这两个集群可以组建成跨数据中心通信，仅限于kv操作。
        - `efk`，日志系统。
        - `grafana`，多个监控系统的看板。
        - `harbor`，私有库，取代docker-registry，部署在k8s集群中，用于完成CI/CD功能，仅用于业务代码部署。但是感觉这个最好不要部署在k8s集群中，因为，万一k8s集群不能用了，harbor镜像拉取功能也没有了。仅用于实验性部署。
        - `mysql-master-slave`，用于部署mysql主从，此目录下的子目录表示一个项目应用。
        - `prometheus`，监控系统。
        - `redis-cluster`，集群模式，使用statefulset模式部署，动态申请pvc，现在使用的nfs后端存储。
        - `redis-standalone`，单机版redis。
            - `common`，使用的是nfs后端存储。
            - `rbd`，使用的是rbd后端存储，所以在那里多了一个secret的yaml文件。
        - `zabbix`，内部的zabbix监控服务器。
        - `zookeeper`，zookeeper集群。
     
    - `ingress`，所有七层业务的入口，实现方式：外部一台主机使用haproxy做负载均衡，使用TCP转发，监听80/443，此端口指向k8s集群中的ingress的nodeport端口即可。