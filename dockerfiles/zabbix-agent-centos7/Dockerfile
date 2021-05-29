FROM harbor.freedom.org/zabbix/zabbix-agent:4.0-centos-latest

LABEL AUTHOR="Wanghaohao"

USER 0

# 将一些通用的监控脚本放入镜像中，替代原镜像中的PVC配置。
ADD files/zabbix_agentd.d /etc/zabbix/zabbix_agentd.d
ADD files/scripts /etc/zabbix/scripts
RUN set -eux && \
    chmod a+x /etc/zabbix/scripts/*.sh

RUN set -eux && \
    yum -y install iproute \
                   net-tools