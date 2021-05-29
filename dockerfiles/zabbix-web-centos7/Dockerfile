FROM harbor.freedom.org/zabbix/zabbix-web-apache-mysql:centos-4.0.17

LABEL AUTHOR="Wanghaohao"

# 使用官方zabbix-web-apache-mysql镜像，增加中文支持，解决中文乱码问题。
ADD files/fonts/msyh.ttf /usr/share/fonts
RUN set -eux && sed -i 's/DejaVuSans/msyh/' /usr/share/zabbix/include/defines.inc.php