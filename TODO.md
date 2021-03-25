# 2021/03/25
- 建立环境：创建一台虚拟机部署prometheus用来替代rancher中的prometheus，原因是考虑到监控为基础设施类的服务，应该独立出来，再加上，之前也在k8s中成功部署，所以说实施这一关也没有问题。

- 确认监控对象：虚拟机（普通虚拟机和K8S集群虚拟机）, k8s集群中pods对象。

- 确认监控方法及监控指标：prometheus服务独立部署出来后，使用USE方法监控。USE方法监控扩展知识如下：
```
USE方法全称”Utilization Saturation and Errors Method”，主要用于分析系统性能问题，可以指导用户快速识别资源瓶颈以及错误的方法。
正如USE方法的名字所表示的含义，USE方法主要关注与资源的：使用率(Utilization)、饱和度(Saturation)以及错误(Errors)。

    - 使用率：关注系统资源的使用情况。 这里的资源主要包括但不限于：CPU，内存，网络，磁盘等等。100%的使用率通常是系统性能瓶颈的标志。

    - 饱和度：例如CPU的平均运行排队长度，这里主要是针对资源的饱和度(注意，不同于4大黄金信号)。
             任何资源在某种程度上的饱和都可能导致系统性能的下降。

    - 错误：错误计数。例如：“网卡在数据包传输过程中检测到的以太网网络冲突了14次”。
```
- 确认自动发现配置实现方法：
    - 当前环境情况，内部有consul-server集群，除consul-server主机外，其他都有安装consul-agent，可以依赖consul来完成自动发现配置。
    - prometheus中众多自动发现配置，其中有`consul_sd_config`，`file_sd_config`和`kubernetes_sd_config`。根据当前环境来看，使用`file_sd_config`和`kubernetes_sd_config`，其中`file_sd_config`则由consul-template自动渲染完成。
    - `kubernetes_sd_config`，则按照官方文档指导完成k8s相关资源监控。

# 2020/10/08
- 使用cephFS，https://blog.csdn.net/weixin_34211761/article/details/92761142，rbd虽然可以用，但是呢，每个pvc分不太清是哪个pod挂的，有点麻烦，并且在mysql下挂的时候，会报权限问题，随后切到nfs即可。