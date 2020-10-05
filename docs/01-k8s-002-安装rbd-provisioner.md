# nfs-client-provisioner安装说明文档

## storage-class类型，ceph rbd提供pvc功能，生产环境首选。

##1.准备工作
- 准备ceph集群，其版本最高为mimic，即为13，这是因为quay.io/external_storage/rbd-provisioner:v2.1.1-k8s1.11镜像最高只支持这个版本。
- 在k8s主机上能进行创建rbd块，格式化，挂载及写入文件的测试。
    
##2.安装
- 创建所需名字空间：`kubectl create namespace production-storage-class-rbd`

- 安装：
```shell
   # cd k8s-datacenter/production/storage-class-rbd/common
   
   # hosts='master.k8s.freedom.org
           worker01.k8s.freedom.org
           worker02.k8s.freedom.org
           worker03.k8s.freedom.org'
   # for host in $hosts
    do
        scp ceph.client.admin.keyring ceph.conf
    done
    
   # kubectl apply -f ceph-rbd-provisioner.yaml
   # kubectl apply -f ceph-secret.yaml
   # kubectl apply -f ceph-storage-class.yaml
   # kubectl apply -f ceph-storage-class-pvc.yaml
```

    
- 查看pvc状态，如果有不成功请自行排错。