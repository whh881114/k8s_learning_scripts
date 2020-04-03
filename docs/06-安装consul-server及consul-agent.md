# consul-server及consul-agent安装说明文档

### 前言
- consul-server采用stateful部署。
- consul-agent采用daemonset部署。

## 1. 安装步骤
- consul-server集群安装
    ```shell
    cd laboratory/consul-server
    kubectl apply -f laboratory-statefulset-consul-server.yaml
    kubectl apply -f laboratory-svc-consul-server.yaml
    ```

- consul-agent安装
    ```shell
    cd laboratory/consul-agent
    kubectl apply -f laboratory-ds-consul-agent.yaml
    ```
    
## 2. 导流（映射WEB服务）
- 在master.k8s.example.com安装nginx反向代理，配置文件在此目录中laboratory/proxy/nginx/conf.d/consul.lb.example.com.conf。

## 3. 接入外部的consul-agent
- forman.example.com安装consul，并以agent运行，可以与consul server cluster通信，但是服务未注册上去，后续还需要优化。
    ```shell
    [root@foreman.example.com ~ 18:01]# 91> consul members
    Node                    Address               Status  Type    Build  Protocol  DC   Segment
    consul-server-0         10.244.1.14:8301      alive   server  1.6.2  2         dc1  <all>
    consul-server-1         10.244.3.17:8301      alive   server  1.6.2  2         dc1  <all>
    consul-server-2         10.244.2.19:8301      alive   server  1.6.2  2         dc1  <all>
    foreman.example.com     192.168.255.252:8301  alive   client  1.6.2  2         dc1  <default>
    master.k8s.example.com  192.168.255.211:8301  alive   client  1.6.2  2         dc1  <default>
    node01.k8s.example.com  192.168.255.212:8301  alive   client  1.6.2  2         dc1  <default>
    node02.k8s.example.com  192.168.255.213:8301  alive   client  1.6.2  2         dc1  <default>
    node03.k8s.example.com  192.168.255.214:8301  alive   client  1.6.2  2         dc1  <default>
    [root@foreman.example.com ~ 18:01]# 92> 
    ```