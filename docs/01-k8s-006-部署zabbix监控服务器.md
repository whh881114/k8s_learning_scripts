# zabbix安装说明文档

## 1. 安装步骤
- 允许master节点部署Pod，命令为：`kubectl taint nodes --all node-role.kubernetes.io/master-`


- 安装zabbix-mysql
    ```shell
    kubectl create namespace production-zabbix
    cd k8s-datacenter/production/zabbix/mysql
    kubectl apply -f .
    ```
    
- 安装zabbix-server
    ```shell
    cd k8s-datacenter/production/zabbix/server
    kubectl apply -f .
    ```

- 安装zabbix-web
    ```shell
    cd k8s-datacenter/production/zabbix/web
    kubectl apply -f .
    ```

- 安装zabbix-agent
    ```shell
    cd k8s-datacenter/production/zabbix/agent
    kubectl apply -f .
    ```
    
## 2. 导流（映射服务）
- **很久很久以前**
    - 在lb.freedom.org安装nginx进行反向代理，配置文件在此目录中proxy/nginx，nginx服务来代理http/https服务，
    目录proxy/haproxy则为代理tcp/udp服务。
    
    - 代理zabbix服务，nginx主配置文件为proxy/nginx/nginx.conf，子配置文件为proxy/nginx/conf.d/zabbix.k8s.freedom.org.conf。

- **2020/10/05**
    - 负载全更换为haproxy，不再使用nginx。

## 3. 细节问题
- zabbix-server，部署时，需在在pod里指定两个容器，一个是zabbi-agent，另一个是zabbix-server，这样的话zabbix-agent和zabbix-server
共享pod ip地址，所以就能实现监控zabbix-server本身了。另外，zabbix-agent不需要挂pvc来放自定义监控脚本。

- zabbix-server部署时，必须要使用**headless**来暴露服务，这时候服务域名解析出来的就是pod ip地址，这样在web界面上设置zabbix-server地址
时使用域名即能解决zabbix-agent unreachable on zabbix-server的问题了。

- 部署zabbix-agent在node上时，需要把配置文件中的zabbix-server地址改成node节点的网段这样才能解决节点上报zabbix-agent unreachable
的问题了。否则就会在某些节点报类似于这样的错误：`62:20200215:162503.203 failed to accept an incoming connection: connection 
from "192.168.255.250" rejected, allowed hosts: "zabbix.k8s.example.com"`，这里要思考下，zabbix-server明显是使用pod地址与
其他pod，node来通信的，为什么在这里会是zabbix-server pod所在的node地址呢，这是因为flannel网络组件工作原理机制，pod与其他节点通信
时，会经过自己所在的节点网桥把地址改写node地址，并把pod地址与在数据包中，所以对外通信时就显示为node的地址了，
也就是本条消息中的`192.168.255.250`了。此时记录的记录是在上次的实验中碰到的。


## 4. 后续优化
- zabbix-agent，部署时，使用daemonset方式部署，还需要挂载本地碰盘目录，用于存放自定义监控项。（于2020/05/03完成。）
- 环境变量，使用configMap存放基础变量，secret来存放数据库密码。但是secret是base64位加密，其实也不安全，因为解密很快，为了方便实验，就全用confiMap来实现。