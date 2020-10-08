# harbor部署
- harbor官网：https://github.com/goharbor/harbor

- harbor部署在k8s集群上，是需要使用harbor的chart来部署，另外，helm就用版本3即可，方便又简单。使用chart部署地址：https://github.com/goharbor/harbor-helm

- 下载chart，使用命令：`helm pull harbor/harbor`，配置文件就在当前目录下的`values.yaml`，可以自行参考。


- 主要对配置文件修改过程作以下说明：

    - 我是先到rancher管理界面上查看了app页面，是可以直接部署的，索性一想，反正都是使用chart部署，就先在页面点上点击配置即可，照着上面的选择即可，安装是成功，页面可以正常访问，第一次配置也是瞎选，最后发现都不知道如何使用harbor，还做了各种瞎操作。
    
    - 后来索性下载chart，然后对着官网的说明来配置，因为有了之前在rancher管理界面上配置的经验，所以就对修改配置文件还有点信心，认真读里面的说明，主要是以下几点：
    
        - type: nodePort，选择为nodePort模式，因为要对外提供访问。
        
        - tls --> enabled: false，后端使用http协议，不使用https，这是因为harbor会部署在haproxy服务器后端，haproxy提供https协议即可。
        
        - nodePort，此处的配置使用默认值即可，像其他的暴露方式ingress/clusterIP/loadBalancer就完全忽略掉即可，因为这是多选一。
        
        - externalURL，这里其实就是一个说明提示，你不配置或者配置错了也关系，因为这个我之前在rancher上配置错了，但是我知道如何访问harbor配置页面。在我的环境下其地址是：`harbor.freedom.org`。
        
        - internalTLS --> enabled: false，内部通信全关掉https即可。
        
        - persistence --> enabled: true，开启持外化，persistentVolumeClaim下的`registry/chartmuseum/jobservice/database/redis/trivy`这几个都开启，因为是第一次配置，所以只用指定`storageClass: "rbd-provisioner-common"`即可，大小可以自己调整；如果是多次部署，那么就要在`existingClaim`指定了，两都配置是互斥。
        
        - imageChartStorage --> type: filesystem，这个是默认值，保持即可。
        
        - 其他的配置项，就使用默认值即可。
        
- 安装chart，进入chart的目录，然后使用命令：`helm install harbor . -n production-harbor`


- 排错：
    - haproxy侧必须提供https协议服务，所以需要制作自签名证书，注意记得使用`*.freedom.org`这个泛域名来签发。记得第一次使用rancher界面来部署时就选的是http通信，最后在界面上测试harbor连接时一直报错，但是不知道原因，想一想，真是糗大了。这个可能是受haproxy使用http转docker-registry时都是正常的影响，所以一直没做https，只是后来再次想起tcp 443转rancher时碰到的问题后，发意识到需要配置https。
    
    - 解决https的问题后，再来碰到push镜像报错，在registry中报`level=error msg="response completed with error" auth.user.name=admin err.code="blob unknown"`，解决方法:引用自: `https://github.com/goharbor/harbor/issues/3114#issuecomment-394139225`，删除/注释掉common/config/nginx/nginx.conf中的`proxy_set_header X-Forwarded-Proto $scheme;`，这是因为在haproxy.cfg文件中，已经做过主机头的配置项了，在registry的nginx.cfg中有重复。之前在rancher管理界面中虽然有修改，但是好像没有重启registry的容器，所以一直没成功。（这个有没有删除registry容器等重建的操作，现在想不起来了。）