# nfs-client-provisioner安装说明文档

##1.准备工作
- 准备一台nfs服务器，此实验中的例子为192.168.255.252，目录为/data/k8s_nfs_pvc，修改其权限命令：
    ```shell
    chown -R polkitd:nfsnobody /data/k8s_nfs_pvc/cattle-prometheus
    chown -R polkitd:nfsnobody /data/k8s_nfs_pvc/public-infra
    chown -R polkitd:nfsnobody /data/k8s_nfs_pvc/laboratory
    ````

- /etc/exports配置文件
    ```shell
    /data/k8s_nfs_pvc/cattle-prometheus         192.168.255.0/24(insecure,rw,sync,no_root_squash)
    /data/k8s_nfs_pvc/public-infra              192.168.255.0/24(insecure,rw,sync,no_root_squash)
    /data/k8s_nfs_pvc/laboratory                192.168.255.0/24(insecure,rw,sync,no_root_squash)
    ```
    
##2.安装
- 创建所需名字空间：`kubectl create namespace nfs-client-provisioner`
- 安装命令：
    ```
    cd nfs-client-provisioner
    
    kubectl apply -f ncp-sa.yaml 
    
    kubectl apply -f cattle-prometheus/
    kubectl apply -f laboratory/
    kubectl apply -f public-infra/
    ```
- 查看pod状态：`kubectl get pods -o wide --all-namespaces`