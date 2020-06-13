#!/bin/bash

repos='base
extras
updates
epel
mysql-connectors-community
mysql-tools-community
mysql57-community
salt-2019.2
zabbix
zabbix-non-supported
group_theforeman-tfm-ror51
foreman
foreman-plugins
centos-sclo-rh
centos-sclo-sclo
puppet5
kubernetes'

for repo in $repos 
do
    echo "===== Start syncing $repo from cloud. ====="
    /usr/bin/reposync --repoid=$repo -p /data/yum/7
    echo
    echo
done


for repo in $repos
do
    echo "===== Start creating repo database for ${repo}. ====="
    cd /data/yum/7/$repo
    /usr/bin/createrepo --workers=4 .
    echo
    echo
done
