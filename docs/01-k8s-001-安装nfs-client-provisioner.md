# nfs-client-provisioner安装说明文档

## storage-class类型，nfs提供pvc功能，其中重点是修改权限这一行，特别是polkitd用户。

##1.准备工作
- 准备一台nfs服务器，此实验中的例子为`nfs.freedom.org`，目录为/data/k8s-nfs-pvc，修改其权限命令：
    ```shell
    chown -R polkitd:nfsnobody /data/k8s-nfs-pvc/infra
    chown -R polkitd:nfsnobody /data/k8s-nfs-pvc/mysql
    chown -R polkitd:nfsnobody /data/k8s-nfs-pvc/redis-standalone
    chown -R polkitd:nfsnobody /data/k8s-nfs-pvc/redis-cluster
    ````

- /etc/exports配置文件
    ```shell
    /data/k8s-nfs-pvc/infra                 192.168.2.0/24(insecure,rw,sync,no_root_squash)
    /data/k8s-nfs-pvc/mysql                 192.168.2.0/24(insecure,rw,sync,no_root_squash)
    /data/k8s-nfs-pvc/redis-standalone      192.168.2.0/24(insecure,rw,sync,no_root_squash)
    /data/k8s-nfs-pvc/redis-cluster         192.168.2.0/24(insecure,rw,sync,no_root_squash)
    ```
    
##2.安装
- 创建所需名字空间：`kubectl create namespace nfs-client-provisioner`
- 安装命令：
    ```
    cd public-infra/nfs-client-provisioner
    
    kubectl apply -f cattle-prometheus/
    kubectl apply -f efk/
    kubectl apply -f laboratory/
    kubectl apply -f public-infra/
    ```
- 查看pod状态：`kubectl get pods -o wide --all-namespaces`