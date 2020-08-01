# k8s学习之旅

## 目录说明
- `ansible_playbooks`，用于自动化部署，不仅仅用于k8s环境，还有适用于其他环境部署。
- `docs`，文档目录，用于记录各种安装记录及实验细节。
- `k8s_platform`，用于安装k8s平台相关的软件。
    - `base`，使用ansible-playbook安装完k8s集群后，需要安装另外的ingress及flannel组件。
    - `named`，使用bind搭建dns服务器。
    - `proxy`，将k8s里配置的公共服务代理出来，nginx用于代理http协议，haproxy代理tcp协议，因为haproxy配置起来方便，
    - `rancher`，安装k8s管理界面，这个装好了，只是方便管理提升效率，如果不用rancher，完全是可以用kubectl及书写yml文件来完成。
    - `scripts`，脚本目录。
    - `repo`，用于配置yum源，不过现在感觉没啥用，因为现有的环境是使用原来yum服务器，不过可以全换成阿里源。
- `public-infra`，用于在k8s上部署基础服务类（公共服务类）的，如单机版的redis，redis集群和zabbix监控服务等。
- `traning`，用于学习的实验。