# 使用官方镜像，然后加上自己的配置文件，方便在单机模式下跑容器。
FROM redis:5.0.12

LABEL MAINTAINER="Wanghaohao"

WORKDIR /usr/local/etc/redis/
COPY redis.conf redis.conf

WORKDIR /data
VOLUME /data

CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]