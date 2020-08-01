# yaml文件名规范说明


## - pv命名规范
格式：{NAMESPACE}-pv-{PV_TYPE}-{APP_NAME}  
正则：(.*)-pv-(.*)-(.*)  
示例：laboratory-pv-nfs-redis-standalone  
说明：  
- 分隔符为-。  
- 第一个字段为命令空间。
- 第二个字段为k8s上的资源类型，此时为pv，固定值。  
- 第三个字段为哪种存储服务提供持久化功能，如nfs，hostPath之类的。  
- 第四个字段为应用名，名称有多个单词可以使用-连接，如果写成其他格式也是支持的。  


## - pvc命名规范
格式：{NAMESPACE}-pvc-{APP_NAME}  
正则：(.*)-pvc-(.*)  
示例：laboratory-pvc-redis-standalone  
说明：  
- 分隔符为-。  
- 第一个字段为命令空间。
- 第二个字段为k8s上的资源类型，此时为pvc，固定值。   
- 第三个字段为应用名，名称有多个单词可以使用-连接，如果写成其他格式也是支持的。  
备注：  
- 此时的pvc没有指明存储类型，这个是正常的，因为pvc就是来屏蔽存储类型，所以就删除了。  


## - deploy命名规范
格式：{NAMESPACE}-deploy-{APP_NAME}  
正则：(.*)-deploy-(.*)  
示例：laboratory-deploy-redis-standalone  
说明：  
- 分隔符为-。  
- 第一个字段为命令空间。
- 第二个字段为k8s上的资源类型，此时为deploy，固定值。   
- 第三个字段为应用名，名称有多个单词可以使用-连接，如果写成其他格式也是支持的。  


## -svc命名规范
格式：{NAMESPACE}-svc-{APP_NAME}  
正则：(.*)-svc-(.*)  
示例：laboratory-svc-redis-standalone  
说明：  
- 分隔符为-。  
- 第一个字段为命令空间。
- 第二个字段为k8s上的资源类型，此时为svc，固定值。   
- 第三个字段为应用名，名称有多个单词可以使用-连接，如果写成其他格式也是支持的。  


## -cm命名规范
格式：{NAMESPACE}-cm-{APP_NAME}  
正则：(.*)-cm-(.*)  
示例：laboratory-cm-redis-standalone.conf  
说明：  
- 分隔符为-。  
- 第一个字段为命令空间。
- 第二个字段为k8s上的资源类型，此时为cm(configMap)，固定值。   
- 第三个字段为应用名，名称有多个单词可以使用-连接，如果写成其他格式也是支持的。 