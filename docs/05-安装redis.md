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
    cd public-infra/redis/redis-standalone
    kubectl create namespace redis
    kubectl apply -f .
    
    cd redis-cluster
    kubectl apply -f .
    ```
    
## 2. 导流（映射服务）
- 在lb.freedom.org安装haproxy进行TCP代理，配置文件片断在此目录中laboratory/proxy/haproxy/redis.cfg。

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