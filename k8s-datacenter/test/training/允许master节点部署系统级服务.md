#允许master节点部署系统级服务

## 开启命令：
\# kubectl taint nodes --all node-role.kubernetes.io/master-

## 关闭命令：
\# kubectl taint nodes master.k8s.example.com node-role.kubernetes.io/master=true:NoSchedule

master.k8s.example.com，为k8s集群中的master节点名称。