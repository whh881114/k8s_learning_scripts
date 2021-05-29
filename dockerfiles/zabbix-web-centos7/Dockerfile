FROM harbor.freedom.org/zabbix/zabbix-web-apache-mysql:centos-4.0.17

LABEL AUTHOR="Wanghaohao"

# 使用官方zabbix-web-apache-mysql镜像，增加中文支持，解决中文乱码问题。
ADD files/fonts/msyh.ttf /usr/share/fonts
RUN set -eux && \
    sed -i "s#realpath('assets/fonts')#'/usr/share/fonts#" /usr/share/zabbix/include/defines.inc.php && \
    sed -i "s/DejaVuSans/msyh/" /usr/share/zabbix/include/defines.inc.php

# define('ZBX_FONTPATH',                          realpath('assets/fonts')); // where to search for font (GD > 2.0.18)
# define('ZBX_GRAPH_FONT_NAME',           'DejaVuSans'); // font file name
# define('ZBX_FONT_NAME', 'DejaVuSans');