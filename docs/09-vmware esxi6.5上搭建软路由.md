# 09-vmware esxi6.5上搭建软路由

### 前言
- vmware workstation与esxi的网络有点不一样，在workstation中可以轻松使用nat网络，但在esxi中没有，所以需要自己搭一个软路由。这里在网上找了一个叫pfSense的软件。

## 1. pfSense官网
- https://www.pfsense.org/download/

- 安装起来没啥难度。
  
    
## 2. 后记
- 最开始使用centos7系统做nat服务器，但是开了firewalld后，发现集群无法正常工作，排查起来也麻烦，干脆搭一个，省事。

- ip地址规划，用于记录而已。
    - 192.168.1.254 --> esxi 6.5 --> 物理机
    
    - 192.168.1.253 --> foreman.freedom.org --> 核心服务器
    
    - 192.168.1.252 --> foreman.example.com --> 台式机上的核心服务器
    
    - 192.168.255.251  --> master.k8s.freedom.org --> 用于上传代码用
    
    - 192.168.255.250 --> lb.freedom.org --> 模拟外部真实负载均衡
    
    - pfsense搭建软路由, 192.168.1.249用于外网，192.168.2.249用于内网，作为NAT网络的网关。
      pfsense                 IN      A       192.168.1.249