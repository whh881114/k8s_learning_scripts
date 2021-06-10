FROM harbor.freedom.org/docker.io/centos:7.9.2009

LABEL AUTHOR="Wanghaohao"

# 使用内部yum源安装基础包。
RUN set -eux && rm -rf /etc/yum.repos.d/*
ADD repos /etc/yum.repos.d/
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
                   tree \
                   git \
                   wget

# 配置vim。
ADD files/vim/vimrc /root/.vimrc

# 配置ssh-key，使用foreman.freedom.org主机的，配置ssh-key主要是为了git能使用ssh协议拉取代码仓库。
RUN set -eux && cd /root && mkdir .ssh && chmod 700 .ssh
ADD files/ssh-keys /root/.ssh/
RUN set -eux && cd /root/.ssh && chmod 600 id_rsa && chmod 644 id_rsa.pub