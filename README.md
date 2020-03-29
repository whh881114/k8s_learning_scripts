# k8s v1.16.2学习之旅

## 1. 目录说明
### 1.1. ansible_playbooks
此目录用于初始化k8s-masters及k8s-nodes基础环境，不涉及到安装，因为初始安装后，还需要调整网络，之前碰到一些坑了，这个就先手动调整下，之后可以考虑做成自动化。
### 1.2. docs
安装说明文档。
### 1.3. intrastructure
基础环境，搭建这些服务的一些配置文件。

- named  
域名解析服务，named.conf及named.rfc1912.zones为配置文件，*.example.com.(rev)?.zone文件为数据文件。

- repo  
用于搭建本地仓库，使用ftp对外提供下载。