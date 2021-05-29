FROM harbor.freedom.org/roy/common-centos7:latest

LABEL AUTHOR="Wanghaohao"

RUN rm -rf /etc/yum.repos.d/*

ADD repos /etc/yum.repos.d/

RUN set -eux && \
    yum -y install ftp://foreman.freedom.org/pub/yum/7/jenkins/jenkins-2.277.3-1.1.noarch.rpm \
                   docker-ce \
                   kubectl

WORKDIR /data

VOLUME /data

EXPOSE 8080
EXPOSE 50000

ADD entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]