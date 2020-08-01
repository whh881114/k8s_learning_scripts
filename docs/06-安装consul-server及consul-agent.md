# consul-server及consul-agent安装说明文档

### 前言
- consul-server采用stateful部署。
- consul-agent采用daemonset部署。

## 1. 安装步骤
- consul-server集群安装
    ```shell
    kubectl create namespace consul
    
    cd public-infra/consul
    kubectl apply -f public-infra-statefulset-consul-server.yaml
    kubectl apply -f public-infra-svc-consul-server.yaml
    ```

- consul-agent安装
    ```shell
    cd public-infra/consul
    kubectl apply -f public-infra-ds-consul-agent.yaml
    ```
    
## 2. 导流（映射WEB服务）
- consul agent使用ds模式，会占用主机的8301，8500和8600端口。

- consul server部署服务时，使用的是ClusterIP模式暴露服务。为什么不用NodePort模式？因为当时没想到，在网上看到的文章也没看到是NodePort模式，限制了自己的思维，索性一条路走到黑，试试在ClusterIP模式下，把consul ui服务暴露出来，思路就是使用ingress-nginx代理出来。最开始自己把nginx/haproxy代理安装在k8s集群中，所以ingress-nginx的服务没有使用NodePort模式，当LB是外部时，那么就必须要用到这个模式了。

- 在lb.freedom.org安装nginx反向代理，配置文件在此目录中proxy/nginx/conf.d/consul.k8s.freedom.org.conf，此时只是暴露出ui服务，测试是通过的。

- 当打算用反向代理把consul server的8301端口服务映射出来，发现这个是TCP协议，那还要用到ingress-nginx的四层代理，官言文档：https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/exposing-tcp-udp-services.md，此外，nginx做代理里配置比反向代理还复杂些，还没有haproxy来得方便些。

- 最后决定，还是将服务暴露方式改为NodePort，最省事。

## 3. 接入外部的consul-agent
- 将配置文件proxy/haproxy/consul.cfg文件加到haproxy.cfg中，然后reload haproxy服务。

    ```shell
    [root@lb.freedom.org ~ 22:29]# 56> consul members
    Node                      Address             Status  Type    Build  Protocol  DC   Segment
    consul-server-0           10.244.2.21:8301    alive   server  1.7.2  2         dc1  <all>
    consul-server-1           10.244.3.21:8301    alive   server  1.7.2  2         dc1  <all>
    consul-server-2           10.244.1.31:8301    alive   server  1.7.2  2         dc1  <all>
    lb.freedom.org            192.168.1.250:8301  alive   client  1.6.2  2         dc1  <default>
    master.k8s.freedom.org    192.168.2.1:8301    alive   client  1.7.2  2         dc1  <default>
    worker01.k8s.freedom.org  192.168.2.2:8301    alive   client  1.7.2  2         dc1  <default>
    worker02.k8s.freedom.org  192.168.2.3:8301    alive   client  1.7.2  2         dc1  <default>
    worker03.k8s.freedom.org  192.168.2.4:8301    alive   client  1.7.2  2         dc1  <default>
    [root@lb.freedom.org ~ 22:29]# 57> 
    ```