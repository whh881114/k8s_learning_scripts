#!/bin/bash

namespace=mysql
db_pods=`kubectl get pods -n $namespace | grep -v '^NAME' | awk '{print $1}'`

for db_pod in $db_pods
do
  sed -e "s/mysqld-exporter-sample/mysqld-exporter-${db_pod/-0/}/g" -e "s/replace_mysql_inst_here/${db_pod/-0/}.$namespace.svc.cluster.local/g" sample.yaml >  ${db_pod/-0/}.yaml
done

db_pod_svcs=`kubectl get svc -n prometheus | grep -v 'NAME' | awk '{print $1}'`
for db_pod_svc in $db_pod_svcs
do
  echo "- $db_pod_svc.prometheus.svc.cluster.local:9104"
done


# 需要在db中创建一个授权账号。
#db_instances='10.43.147.238
#10.43.239.38
#10.43.231.114
#10.43.250.166
#10.43.115.138
#10.43.113.198
#10.43.66.126
#10.43.21.185
#10.43.60.114
#10.43.48.41
#10.43.238.191
#10.43.31.122
#10.43.252.121
#10.43.238.90
#10.43.164.11
#10.43.29.24
#10.43.165.20
#10.43.222.1
#10.43.158.144'
#
#for db in $db_instances
#do
#  mysql -h $db -uroot -p"MyPassword007." -e "GRANT PROCESS, REPLICATION CLIENT ON *.* TO 'dbcheck'@'%' IDENTIFIED BY 'zuwllczEh35mjvavarGpnhyjzut[hpir';"
#  mysql -h $db -uroot -p"MyPassword007." -e "GRANT SELECT ON performance_schema.* TO 'dbcheck'@'%';"
#  mysql -h $db -uroot -p"MyPassword007." -e "FLUSH PRIVILEGES;"
#done