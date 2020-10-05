# k8s集群使用ingress-nginx说明文档

### 前言
- k8s默认的kube-proxy为四层代理，为了实现http/https代理，则需要使用到ingress-nginx，github官网：https://github.com/kubernetes/ingress-nginx。

## 1. ingress-nginx安装步骤
- 官方安装说明文档：https://github.com/kubernetes/ingress-nginx/blob/master/docs/deploy/index.md。

- 步骤其实就一步，`cd k8s-platform/ingress && kubectl apply -f ingress-nginx-0.28.0-mandatory-deployment.yaml`。
  
    
## 2. 安装LAMP环境
### 2.1. 安装liunx环境
- 因为是容器环境，所以linux系统环境就不需要准备了。

### 2.2. 安装apache/php环境
- 最开始是使用LNMP环境，使用了官方容器镜像nginx:1.17.8和php:fpm，先是每个镜像放在一个容器中，然后两个镜像放在同一个Pod中，测试时发现php文件始终无法解析，登录容器后无法使用ping或nc之类的命令检查php-fpm的连接是否正常，所以放弃了这一步。

- 后来只好使用centos官方镜像安装php-fpm包，此时发现也会安装apache，所就是改为LAMP环境。代码仓库地址：https://github.com/whh881114/lnmp-api，打包docker镜像操作均在Dockerfile中。

- 安装命令
    ```shell
    cd ci-cd-demos/lamp/api/apache
    kubectl apply -f ci-cd-demos-pvc-apache.yaml
    kubectl apply -f ci-cd-demos-deploy-apache.yaml
    kubectl apply -f ci-cd-demos-svc-apache.yaml
    ```

### 2.3. 安装mysql环境
- 安装步骤：
    ```shell
    cd ci-cd-demos/lamp/api/mysql
    kubectl -n ci-cd-demos create cm lamp-mysql-conf --from-file=ci-cd-demos-cm-file-mysql.cnf
    kubectl apply -f ci-cd-demos-cm-vars-mysql.yaml
    kubectl apply -f ci-cd-demos-pvc-mysql.yaml
    kubectl apply -f ci-cd-demos-deploy-mysql.yaml
    kubectl apply -f ci-cd-demos-svc-mysql.yaml
    ```

### 3. 安装前端环境
- 基础镜像就使用nginx。

- 代码仓库地址：https://github.com/whh881114/lnmp-frd，打包docker镜像操作均在Dockerfile中。

- 安装命令
    ```shell
    cd ci-cd-demos/lamp/frd
    kubectl apply -f ci-cd-demos-pvc-frd.yaml
    kubectl apply -f ci-cd-demos-deploy-frd.yaml
    kubectl apply -f ci-cd-demos-svc-frd.yaml
    ```
### 4. 配置ingress-nginx
- 为nginx-ingress-controller容器配置服务，命令为：`kubectl apply -f k8s_platform/ingress-nginx-service.yaml`，创建的服务可以在不同的名字空间，这里就定在ingress-nginx中。

- 创建ingress资源，命令为：`kubectl apply -f ci-cd-demos/lamp/ingress-nginx/host-http.yaml`


### 5. 导流（四层代理）
- 这里就推荐使用四层代理，因为转发效率高些，并且后端是nginx-ingress-controller本身就是七层代理了，所以外部的lb就不需要再使用七层代理了。
- haproxy配置内容如下：
    ```shell
    listen laboratory-lamp-http-ingress
        bind        *:40002
        mode        tcp
        balance     source
        server      lamp-http-ingress.example.com 10.106.0.1:80 weight 1 maxconn 10000 check inter 10s
    ```
    
- 客户端测试时，本地写好hosts记录。
    ```shell
    192.168.255.211	api.lamp.example.com
    192.168.255.211	frd.lamp.example.com
    ```