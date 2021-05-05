FROM harbor.freedom.org/docker.io/centos:7.9.2009

LABEL AUTHOR="Wanghaohao"

RUN rm -rf /etc/yum.repos.d/*

ADD repos /etc/yum.repos.d/

RUN set -eux && \
    yum -y install ftp://foreman.freedom.org/pub/yum/7/jenkins/jenkins-2.277.3-1.1.noarch.rpm \
                   docker-ce \
                   supervisor \
                   curl nc telnet java-1.8.0-openjdk java-1.8.0-openjdk-* net-tools