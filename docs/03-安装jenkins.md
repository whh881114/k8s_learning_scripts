# jenkins安装说明文档

## 1. 安装步骤
- 安装
    ```shell
    cd laboratory/jenkins
    kubectl apply -f laboratory-pvc-jenkins.yaml 
    kubectl apply -f laboratory-deploy-jenkins.yaml 
    kubectl apply -f laboratory-svc-jenkins.yaml 
    ```
    
## 2. 导流（映射服务）
- 在master.k8s.example.com安装nginx进行反向代理，配置文件在此目录中laboratory/proxy/nginx，nginx服务来代理http/https服务，
目录laboratory/proxy/haproxy则为代理tcp/udp服务。

- 代理jenkins服务，nginx主配置文件为laboratory/proxy/nginx/nginx.conf，子配置文件为laboratory/proxy/nginx/conf.d/jenkins.lb.example.com.conf。

## 3. 后续
- 之后要在rancher里搭jenkins实现做CI/CD功能。