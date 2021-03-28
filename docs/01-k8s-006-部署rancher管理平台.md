# k8s集群上安装rancher管理平台安装说明文档

### 前言
- rancher可以图形化管理k8s集群，官网地址：https://rancher.com/。

## 1. 安装步骤
- 安装helm工具，下载最新版即可。官网地址：https://helm.sh/docs/intro/install/。

- 官方安装说明文档：https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/behind-proxy/install-rancher/。

- 安装起来没有什么坑，镜像下载还是很顺畅。helm就是版本3，比版本2好用多了。
    
## 2. 导流（映射https服务）
- 因为集群前端有一个haproxy代理到后端的nginx-ingress，是进行tcp转发的，所以导流就使用nginx-ingress完成即可。参考下一篇文章即可。