# k8s集群使用ingress-nginx说明文档

## 前言
- k8s默认的kube-proxy为四层代理，为了实现http/https代理，则需要使用到ingress-nginx，github官网：https://github.com/kubernetes/ingress-nginx。

## 1. ingress-nginx安装步骤
- 官方安装说明文档：https://github.com/kubernetes/ingress-nginx/blob/master/docs/deploy/index.md。

- 使用helm安装，当然只支持helm版本3，命令如下，速度太慢了，可以不用。
    ```
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install ingress-nginx ingress-nginx/ingress-nginx
    ```

- 下载包，再进行安装，地址：https://github.com/kubernetes/ingress-nginx/releases。
    ```
    wget https://github.com/kubernetes/ingress-nginx/releases/download/helm-chart-3.25.0/ingress-nginx-3.25.0.tgz
    tar xf ingress-nginx-3.25.0.tgz
    cd ingress-nginx
    # 修改镜像地址，https://hub.docker.com，搜索willdockerhub/ingress-nginx-controller，找到指定版本。
    # 传到私有harbor服务器中后，可以看到sha的摘要，也需要此文件中修改。
    # 另外，service中的type要改为nodePort。
    vi values.yaml 
    helm install ingress-nginx . -n ingress-nginx
    ``` 