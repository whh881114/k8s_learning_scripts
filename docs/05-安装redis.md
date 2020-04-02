# redis安装说明文档

### 准备工作
- 容器使用自定义配置文件，需要注意一点，配置文件中的daemonize需要设置为no，放在前台运行，如果以后台方式运行，
那么pod就没有任何进程在前台运行，那么pod就会一直处于CrashBackOff状态。

- 此实验中使用到了initContainers，初始化修改内核参数。

## 1. 安装步骤
- 安装
    ```shell
    cd laboratory/config_map_files/redis
    kubectl -n laboratory create configmap redis.conf --from-file=redis.conf 
    
    cd laboratory/redis
    kubectl apply -f laboratory-pvc-redis.yaml
    kubectl apply -f laboratory-deploy-redis.yaml
    kubectl apply -f laboratory-svc-redis.yaml
    ```
    
## 2. 导流（映射服务）
- 在master.k8s.example.com安装haproxy进行TCP代理，配置文件在此目录中laboratory/proxy/haproxy/haproxy.cfg。

    ```shell
    listen laboratory-redis
    bind        *:40000
    mode        tcp
    balance     source
    server      redis.k8s.example.com 10.97.72.56:6379 weight 1 maxconn 10000 check inter 10s
    ```