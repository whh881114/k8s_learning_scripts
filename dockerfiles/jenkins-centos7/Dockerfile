FROM harbor.freedom.org/roy/jenkins-base-centos7:latest

LABEL AUTHOR="Wanghaohao"

WORKDIR /data

VOLUME /data

EXPOSE 8080
EXPOSE 50000

ADD entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]