# zabbix-agent-centos7镜像制作说明：

- 从官网下载Dockerfile，地址：https://github.com/zabbix/zabbix-docker/tree/4.0/agent/centos
- 修改文件里的内容就是找到yum安装软件处，增加软件包名`iproute`，`sysstat`和`net-tools`。
- 复制`docker-entrypoint.sh`文件后，需要加上可执行权限。