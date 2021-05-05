FROM harbor.freedom.org/docker.io/centos:7.9.2009

LABEL AUTHOR="Wanghaohao"

RUN rm -rf /etc/yum.repos.d/*

ADD repos /etc/yum.repos.d/

ADD files/vimrc /root/.vimrc

RUN set -eux && \
    yum -y install curl \
                   nc \
                   telnet \
                   java-1.8.0-openjdk \
                   java-1.8.0-openjdk-* \
                   net-tools \
                   iproute \
                   vim \
                   dos2unix \
                   unix2dos \
                   tree