# fluentd部署说明

- 背景知识
    - https://kubernetes.io/docs/concepts/cluster-administration/logging/
    - https://kubernetes.io/zh/docs/concepts/cluster-administration/logging/
    - https://docs.docker.com/config/containers/logging/configure/
    - https://www.cnblogs.com/operationhome/p/10907591.html
    
- 介绍
    - https://docs.fluentd.org
    - https://docs.fluentd.org/container-deployment/kubernetes
    - https://github.com/fluent/fluentd-kubernetes-daemonset
    
- 规划
    - 容器日志使用`local`引擎，在`daemon.json`文件中加入以下配置。
      ```
      {
        "log-driver": "local",
        "log-opts": {
           "max-size": "100m",
           "max-file": 10,
           "compress": false
        }
      }
      ```
    - 不使用`json`引擎，因为 Docker JSON 日志驱动将日志的每一行当作一条独立的消息。 该日志驱动不直接支持多行消息。
      你需要在日志代理级别或更高级别处理多行消息。