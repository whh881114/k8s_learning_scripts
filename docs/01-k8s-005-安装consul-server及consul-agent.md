# consul-server及consul-agent安装说明文档

### 前言
- consul-server采用stateful部署。
- consul-agent采用daemonset部署。

## 1. 安装步骤
- consul-server集群安装
    ```shell
    kubectl create namespace consul
    
    cd datacenter/infra/consul/dc-k8s
    kubectl apply -f consul-server-statefulset.yaml
    kubectl apply -f consul-server-service.yaml
    ```

- consul-agent安装
    ```shell
    kubectl apply -f consul-agent-daemonset.yaml
    ```
    
## 2. 导流（映射WEB服务）
- **很久以前的思路：**
    - consul agent使用ds模式，会占用主机的8301，8500和8600端口。

    - consul server部署服务时，使用的是ClusterIP模式暴露服务。为什么不用NodePort模式？因为当时没想到，在网上看到的文章也没看到是NodePort模式，限制了自己的思维，索性一条路走到黑，试试在ClusterIP模式下，把consul ui服务暴露出来，思路就是使用ingress-nginx代理出来。最开始自己把nginx/haproxy代理安装在k8s集群中，所以ingress-nginx的服务没有使用NodePort模式，当LB是外部时，那么就必须要用到这个模式了。

    - 在lb.freedom.org安装nginx反向代理，配置文件在此目录中proxy/nginx/conf.d/consul.k8s.freedom.org.conf，此时只是暴露出ui服务，测试是通过的。

    - 当打算用反向代理把consul server的8301端口服务映射出来，发现这个是TCP协议，那还要用到ingress-nginx的四层代理，官言文档：https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/exposing-tcp-udp-services.md，此外，nginx做代理里配置比反向代理还复杂些，还没有haproxy来得方便些。

    - 最后决定，还是将服务暴露方式改为NodePort，最省事。

- **2020/10/05，更新日志：**
    - consul agent部署模式不变。
    
    - consul server部署时，取消了data-dir和config-dir的pvc，因为这个server端没有什么数据好存，丢掉了也没关系。
    
    - 按以前的思路部署起来（采用nodePort暴露服务），初看起来没有什么问题，虚拟机上的agent确实能加入到集群中，但是后来发现，虚拟机上的日志显示他与consul server地址8301通信，但是这个肯定是不通的，因为那个是Pod地址，所以再回过头来看，使用NodePort模式暴露好像有点多此一举。consul server要对外提供服务时，要解决的的问题是虚拟机与Pod地址段通信，所以需要加一条静态路由，所以说，暴露服务的类型不管是NodePort还是headless来说，其实也没有太大区别，不过推荐是NodePort模式，毕竟在haproxy做转发时，后端可以是多台主机；如果是headless模式，那所有的流量只能走一台主机。另外，虚拟机与Pod直接通信时，还是不要有大量通信为好，因为所有流量只走一台主机，他将会成为瓶颈。
    
## 3. 接入外部的consul-agent
- 将k8s的consul-agent配置文件分发到k8s集群主机下的/etc/consul-agent/conf目录下，然后将consul-agent容器全删除掉，即重启服务。

    ```shell
    [root@foreman.freedom.org ~ 14:37]# 24> consul members
    Node                      Address             Status  Type    Build  Protocol  DC              Segment
    consul-server-0           10.244.3.114:8301   alive   server  1.8.4  2         k8s-production  <all>
    consul-server-1           10.244.1.101:8301   alive   server  1.8.4  2         k8s-production  <all>
    consul-server-2           10.244.0.39:8301    alive   server  1.8.4  2         k8s-production  <all>
    foreman.freedom.org       192.168.2.253:8301  alive   client  1.8.0  2         k8s-production  <default>
    haproxy.freedom.org       192.168.2.250:8301  alive   client  1.8.0  2         k8s-production  <default>
    master.k8s.freedom.org    192.168.2.1:8301    alive   client  1.8.4  2         k8s-production  <default>
    node01.ceph.freedom.org   192.168.2.21:8301   alive   client  1.8.0  2         k8s-production  <default>
    node02.ceph.freedom.org   192.168.2.22:8301   alive   client  1.8.0  2         k8s-production  <default>
    node03.ceph.freedom.org   192.168.2.23:8301   alive   client  1.8.0  2         k8s-production  <default>
    ns01.freedom.org          192.168.2.252:8301  alive   client  1.8.0  2         k8s-production  <default>
    ns02.freedom.org          192.168.2.251:8301  alive   client  1.8.0  2         k8s-production  <default>
    worker01.k8s.freedom.org  192.168.2.2:8301    alive   client  1.8.4  2         k8s-production  <default>
    worker02.k8s.freedom.org  192.168.2.3:8301    alive   client  1.8.4  2         k8s-production  <default>
    worker03.k8s.freedom.org  192.168.2.4:8301    alive   client  1.8.4  2         k8s-production  <default>
    [root@foreman.freedom.org ~ 14:37]# 25> 
    ```