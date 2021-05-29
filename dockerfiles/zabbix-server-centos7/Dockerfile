FROM harbor.freedom.org/zabbix/zabbix-server-mysql:centos-4.0.17

LABEL AUTHOR="Wanghaohao"

# 增加告警脚本
COPY files/alertscripts/personal_cloud_robot.sh /usr/lib/zabbix/alertscripts/personal_cloud_robot.sh
RUN set -eux && \
    chmod 755 /usr/lib/zabbix/alertscripts/personal_cloud_robot.sh