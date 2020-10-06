# k8s学习之旅

## 更新日期：2020/10/05
## 目录说明
- `ansible_playbooks`，用于自动化部署，不仅仅用于k8s环境，还适用于其他环境部署。角色名字变更，增加了序号进行排序，这是因为在foreman上执行角色时，他是按字母顺序执行，但有时某些角色是需要依赖前一个才能执行，而正好他们的名字排序相反。

- `docs`，文档目录，用于记录各种安装记录及实验细节。

    - `k8s-platform`，用于安装k8s平台相关的软件。
    - `flannel`，k8s网络组件。
    - `ingress`，七层负载均衡。  
    - `rancher`，安装k8s管理界面，这个装好了，只是方便管理提升效率，如果不用rancher，完全是可以用kubectl及书写yml文件来完成。
    
- `k8s-datacenter`，用于在k8s上部署基础服务，按一个k8s集群管理四套环境，可以给不同的主机打上不同环境的标签，这样是节约了master节点数量。
    - `dev`，开发环境。
    - `test`，测试环境。
    - `staging`，联调环境。
    - `production`，生产环境。
        - `infra`，基础设施，存放共用的系统。
            - `harbor`，私有库，取代docker-registry。
            
            - `consul`，如果在一个k8s集群中，只能有一个consul集群，因为consul-agent是以daemonset方式部署在各个worker节点，一次只能加入一个集群。
        
        - `redis-cluster`，集群模式，使用statefulset模式部署，动态申请pvc，现在使用的nfs后端存储。此目录下，还有`common`目录，表示部署后的业务用途，并且还为每个不同的业务用途创建了不同的namespace（感觉有点过于复杂了^_^，但也有好处，利于强迫症患者解压。）
        
        - `redis-standalone`，单机版redis。
            - `common`，使用的是nfs后端存储。
            - `registry`，使用的是rbd后端存储，所以在那里多了一个secret的yaml文件。
            
        - `storage-class-nfs`，storage-class类型，使用nfs提示pvc，这个不利于上生产，毕竟是单点故障，另外，网络，磁盘IO都将是会瓶颈。利于环境快速部署。
        
        - `storage-class-rbd`，storage-class类型，鉴于nfs不足，rbd是个人数据中心首选，但是要求有ceph集群，同时也对运维团队有更高的要求。ceph的运维部署已超过此处的讨论范围。部署时，请自行google，不明白不处可以参考官网，创建不通时多看日志。
        
        - `zabbix`，内部的zabbix监控服务器。

        - `zookeeper`，zookeeper集群。

## 备注
- `production`环境的pvc应该首选rbd存储。