# redis安装说明文档

### 准备工作
- 容器使用自定义配置文件，需要注意一点，配置文件中的daemonize需要设置为no，放在前台运行，如果以后台方式运行，
那么pod就没有任何进程在前台运行，那么pod就会一直处于CrashBackOff状态。

- 此实验中使用到了initContainers，初始化修改内核参数。

- 站在巨人肩膀上完成，https://segmentfault.com/a/1190000018405750。

- 在这里搭一个单机版及一个集群版。

## 1. 安装步骤
- 安装
    ```shell
    cd k8s-datacenter/production/redis-standalone/common
    kubectl create namespace production-redis-standalone
    kubectl apply -f .
    
    cd k8s-datacenter/production/redis-cluster/common       # 集群模式下使用到storage-class动态申请pvc，并且其配置文件要修改，这个是关键，这个是看了RancherLab后进行部署的。
    kubectl apply -f .
    ```
    
## 2. 导流（映射服务）
- 在haproxy.freedom.org安装haproxy进行TCP代理，服务上报是采用consul-agent，模板渲染使用consul-template。

    ```shell
    listen redis-standalone
        bind        *:32651
        mode        tcp
        balance     source
        server      master.k8s.freedom.org master.k8s.freedom.org:32651 weight 1 maxconn 10000 check inter 10s
        server      worker01.k8s.freedom.org worker01.k8s.freedom.org:32651 weight 1 maxconn 10000 check inter 10s
        server      worker02.k8s.freedom.org worker02.k8s.freedom.org:32651 weight 1 maxconn 10000 check inter 10s
        server      worker03.k8s.freedom.org worker03.k8s.freedom.org:32651 weight 1 maxconn 10000 check inter 10s
    
    listen redis-cluster
        bind        *:31896
        mode        tcp
        balance     source
        server      master.k8s.freedom.org master.k8s.freedom.org:31896 weight 1 maxconn 10000 check inter 10s
        server      worker01.k8s.freedom.org worker01.k8s.freedom.org:31896 weight 1 maxconn 10000 check inter 10s
        server      worker02.k8s.freedom.org worker02.k8s.freedom.org:31896 weight 1 maxconn 10000 check inter 10s
        server      worker03.k8s.freedom.org worker03.k8s.freedom.org:31896 weight 1 maxconn 10000 check inter 10s
    ```