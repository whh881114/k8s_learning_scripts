# jenkins-centos7镜像制作说明：

- 使用基础镜像：`harbor.freedom.org/docker.io/centos:7.9.2009`，安装`jenkins`，`docker-ce`和`supervisor`三个服务，其中`supervisor`来管理`jenkins`和`docker-ce`两个服务。
- 测试时发现涉及到了`docker run docker`的问题了，最后测试发现，可以不用`supervisor`管理服务，只需安装`docker-ce`和`jenkins`两个服务即可。
- `docker run docker`参考资料：https://cloud.tencent.com/developer/article/1199395。