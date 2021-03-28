# 00-infra-002-搭建haproxy负载均衡.md

### 前言
- 优先搭建haproxy服务器，为多master节点的k8s集群做准备。

## 部署
- `cd ansible_playbooks && ansible-playbook deploy-haproxy.yml`进行部署即可，所有的配置都在`002-biz-001-haproxy`此角色中。
- 此时haproxy作为k8s集群的负载均衡地址，这里仅做tcp的转发，80/443转发到后端的nginx-ingress，6443转至后端master节点即可。