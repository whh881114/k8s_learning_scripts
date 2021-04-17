# k8s集群上安装rancher管理平台安装说明文档

### 前言
- rancher可以图形化管理k8s集群，官网地址：https://rancher.com/。

## 1. 安装步骤
- 安装helm工具，下载最新版即可。官网地址：https://helm.sh/docs/intro/install/。

- 官方安装说明文档：https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/。

- 安装起来没有什么坑，镜像下载还是很顺畅。helm就是版本3，比版本2好用多了。

- 安装依赖：`必须安装ingress服务`。
    
- 记录安装过程。

    - rancher的域名为：rancher.ingress-nginx.freedom.org。

    - 命令：安装证书管理。
    ```
    helm repo add jetstack https://charts.jetstack.io
    
    kubectl create namespace cert-manager
    
    kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.15.2/cert-manager.crds.yaml
    
    helm upgrade --install cert-manager jetstack/cert-manager \
      --namespace cert-manager --version v0.15.2 \
      --set http_proxy=http://rancher.ingress-nginx.freedom.org \
      --set https_proxy=http://rancher.ingress-nginx.freedom.org \
      --set no_proxy=127.0.0.0/8\\,10.0.0.0/8\\,cattle-system.svc\\,172.16.0.0/12\\,192.168.0.0/16\\,.svc\\,.cluster.local
    ```
   
   - 命令：在集群中部署rancher。
   ```
   helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
   
   kubectl create namespace cattle-system
   
   helm upgrade --install rancher rancher-latest/rancher \
   --namespace cattle-system \
   --set hostname=rancher.ingress-nginx.freedom.org \
   --set proxy=http://rancher.ingress-nginx.freedom.org \
   --set no_proxy=127.0.0.0/8\\,10.0.0.0/8\\,cattle-system.svc\\,172.16.0.0/12\\,192.168.0.0/16\\,.svc\\,.cluster.local
   ```
   
   - 访问：本地配置好hosts记录，然后访问https://rancher.ingress-nginx.freedom.org。