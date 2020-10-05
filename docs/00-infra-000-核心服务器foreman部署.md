# 核心服务器：foreman.freedom.org

- 部署人员核心技术技能要求如下，如果是扎实地学过了RHCE7，那么问题不大，因为在foreman上安装系统其本质就是kickstart的升级：
    - DHCP
    - NAMED
    - TFTP
    - VSFTPD
    - KICKSTART

- 官网：https://theforeman.org/

- 快速安装：https://theforeman.org/manuals/2.1/quickstart_guide.html

- 插件：https://theforeman.org/plugins/，推荐安装插件如下：
    - ANSIBLE，自动化部署安装工具。
    - COLUMN VIEW，用于在页面上显示IP地址。
    - DISCOVERY，用于自动发现局域网经PXE启动的主机，用于自动化安装系统。
    - REMOTE EXECUTION，远程执行命令，当安装ANSIBLE后就有了此功能。
    - TASKS，任务列表，当安装ANSIBLE后就有了此功能。
    
- 部署开始之前，在此foreman主机上安装ansible，执行ansible-playbook deploy-bind-master-slave.yml进行部署DNS服务器。之后按快速安装的命令进行安装，当然foreman里的部署系统安装就是另外的事情了，写起来太麻烦了，以前有个文档，还得继续整改。