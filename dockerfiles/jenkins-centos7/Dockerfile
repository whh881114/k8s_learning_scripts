FROM harbor.freedom.org/roy/common-centos7:latest

LABEL AUTHOR="Wanghaohao"

# 安装jenkins, docker和kubectl工具。
RUN set -eux && rm -rf /etc/yum.repos.d/*
ADD repos /etc/yum.repos.d/
RUN set -eux && \
    yum -y install ftp://foreman.freedom.org/pub/yum/7/jenkins/jenkins-2.277.3-1.1.noarch.rpm \
                   docker-ce \
                   kubectl

# 配置~/.kube/config，这样可以使用kubectl访问集群。
RUN set -eux && cd /root/ && mkdir .kube && chmod 750 .kube
COPY files/kubernetes/kubeconfig /root/.kube/config

WORKDIR /root

VOLUME /data

EXPOSE 8080
EXPOSE 50000

ADD entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]