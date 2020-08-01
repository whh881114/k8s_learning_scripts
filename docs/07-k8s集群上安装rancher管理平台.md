# k8s集群上安装rancher管理平台安装说明文档

### 前言
- rancher可以图形化管理k8s集群，官网地址：https://rancher.com/。

## 1. 安装步骤
- 官方安装说明文档：https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/helm-rancher/。
- 安装起来没有什么坑，镜像下载还是很顺畅。helm就是版本3，比版本2好用多了。
    
## 2. 导流（映射https服务）
- 创建一个service，映射到后端rancher的https端口，**一定是https端口**，多次尝试还是要使用https协议。
    ```shell
    cd rancher
    kubectl apply -f cattle-system-svc-rancher-https.yaml
    ```
- haproxy接入服务，haproxy配置文件在proxy/haproxy/haproxy.cfg。
    ```shell
    # rancher管理控制台，TCP转发，用个正常点的端口8443。
    listen rancher
        bind        *:8443
        mode        tcp
        balance     source
        server      rancher.k8s.freedom.org rancher.k8s.freedom.org:30536 weight 1 maxconn 10000 check inter 10s
        server      worker01.k8s.freedom.org worker01.k8s.freedom.org:30536 weight 1 maxconn 10000 check inter 10s
        server      worker02.k8s.freedom.org worker02.k8s.freedom.org:30536 weight 1 maxconn 10000 check inter 10s
        server      worker03.k8s.freedom.org worker03.k8s.freedom.org:30536 weight 1 maxconn 10000 check inter 10s
    ```