FROM harbor.freedom.org/zabbix/zabbix-server-mysql:centos-4.0.17

LABEL AUTHOR="Wanghaohao"

USER 0

# 增加告警脚本
ADD files/alertscripts /usr/lib/zabbix/alertscripts

RUN set -eux && \
    chmod 755 /usr/lib/zabbix/alertscripts/*.sh