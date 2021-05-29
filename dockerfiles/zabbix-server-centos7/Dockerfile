FROM harbor.freedom.org/zabbix/zabbix-server-mysql:centos-4.0.17

LABEL AUTHOR="Wanghaohao"

USER 0

# 增加告警脚本
WORKDIR /usr/lib/zabbix/alertscripts
ADD files/alertscripts .
RUN set -eux && \
    chmod 755 /usr/lib/zabbix/alertscripts/personal_cloud_robot.sh

WORKDIR /root