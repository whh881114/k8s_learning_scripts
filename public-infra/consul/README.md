# consul server集群搭建说明

- k8s集群内搭的consul server集群要暴露出来给外部机器使用，如注册服务之类的，那就要用特别的方法处理，这是因为consul server和consul agent都是使用相同的端口8301相互通信，而consul agent就采用了ds模式，会占用主机的8301，8500和8600端口。

- 8301这类起注册作用的端口可以使用TCP来暴露，这个可以使用ds模式来部署haproxy转发到consul server的cluster ip。

- 8500这类http协议的可以使用nginx来做代理。