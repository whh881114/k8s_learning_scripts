# k8s学习之旅

## 目录说明
- `ansible_playbooks`，用于自动化部署，不仅仅短用于k8s环境，还有适用于其他环境部署。
- `docs`，文档目录，用于记录各种安装记录及实验细节。
- `k8s_platform`，用于安装k8s平台相关的软件。
- bin，常用命令，主要是放些下载，上传镜像操作。
- helm，部署helm v2.x.x版本。
- k8s_platform，本地部署k8s平台时的一些文档。
- laboratory，实验目录，部署的更正规些。
- pv&pvc，创始pv&pvc目录，此目录可以废弃掉，因为使用了`nfs-client-provisioner`来动态让pvc绑定pv。
- training-20200126，学习的目录，之后会逐渐废弃。