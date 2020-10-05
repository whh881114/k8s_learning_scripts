# 00-infra-002-搭建haproxy负载均衡.md

### 前言
- 需要等到k8s中的consul集群搭好后再来部署haproxy。

## 部署
- `cd ansible_playbooks && ansible-playbook deploy-haproxy.yml`进行部署即可，所有的配置都在`002-biz-001-haproxy`此角色中。后端渲染全依赖consul-agent和consul-template完成。