# consul server集群搭建说明

- consul agent使用ds模式，会占用主机的8301，8500和8600端口。

- consul server部署服务时，使用的是ClusterIP模式暴露服务（为什么不用NodePort模式？因为当时没想到，如果使用了，也是占用了大量的端口，有点浪费。），但这个只能在集群内部访问，如果要暴露出来给外部机器使用，如ui界面查看，就要使用ingress-nginx方法处理。这里仅是七层代理，还有四层代理要做测试。

- 四层代理文档：https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/exposing-tcp-udp-services.md。