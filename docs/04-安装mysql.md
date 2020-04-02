# mysql安装说明文档

## 1. 安装步骤
- 安装
    ```shell
    cd laboratory/config_map_files/mysql
    kubectl -n laboratory create configmap my.cnf --from-file=my.cnf
    
    cd laboratory/mysql
    kubectl apply -f laboratory-cm-mysql.yaml
    kubectl apply -f laboratory-pvc-mysql.yaml
    kubectl apply -f laboratory-deploy-mysql.yaml
    kubectl apply -f laboratory-svc-mysql.yaml
    ```

## 2. 配置用户授权
- 初始安装后，用户只允许在集群网络内部访问，需要授权。
    ```shell
        grant all privileges on `public-data-warehouse`.* to 'Roy'@'%';
        flush privileges;
    ```
    
## 3. 导流（映射服务）
- 在master.k8s.example.com安装haproxy进行TCP代理，配置文件在此目录中laboratory/proxy/haproxy/haproxy.cfg。

    ```shell
    listen laboratory-mysql
        bind        *:40001
        mode        tcp
        balance     source
        server      mysql.k8s.example.com 10.106.220.79:3306 weight 1 maxconn 10000 check inter 10s
    ```