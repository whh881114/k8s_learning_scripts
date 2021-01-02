# 部署EFK记录

- 先上参考资料：
    - https://mp.weixin.qq.com/s?__biz=MzIyMTUwMDMyOQ==&mid=2247494653&idx=1&sn=4a7be81f5851a92821ff297dbcfb1210&chksm=e8396d3bdf4ee42d3a6bc1ff2c6920c0acd7f76d525d9a5ece90e0f8686ca7defda080817abb&scene=0&xtrack=1&key=694ad12351d974dcabcccc6215bdd503ba80465efce410331e85f1df7134542cc2a3c319ff20b752a1eb09ab269bbc1ce5fc0cba4b360633aa32d13329ce97ec66420dd3d404ec8981955dee8fa2acb52557c34c722fa6626a1f3adb3626cf306b2de5e733ad13cafe603fcab7eccfcc7dac6b2fc22bff27aa179b54f7c297b5&ascene=1&uin=MTc3NjA0ODMwMQ%3D%3D&devicetype=Windows+10+x64&version=62090538&lang=zh_CN&exportkey=Ax9nnyal3s9T8Q%2FrqbdJYLk%3D&pass_ticket=GyGb6LDxaKbUL53v4EyXuyCHNDKoWPvH%2FOXwIE05nJiYKKHOraaEKGbr15GFLR3k&wx_header=0
    
    - https://mp.weixin.qq.com/s?__biz=MzIyMTUwMDMyOQ==&mid=2247494666&idx=1&sn=b8066191186892dd4cf2650c67a9b2b8&chksm=e8396accdf4ee3da8b35ea2871091ea590fdf71894b7c05fb80d29f4b6888c2aeb3e942cfc07&scene=0&xtrack=1&key=746aaa0a1205eb9565813cc78bda7daee027c9e72328fc57f93eef0edde95da1ecca68ef15c8c4822f1981d1d91d389c5d4a1cbd9e9331eb6ebb52e2fd06b0b8e98938dd98a753a643cf5818b34a428220d42f657e71788a9d2a611352e271c6722acbc28b9ba9b3ccec35b876d9732c0b98eca493182ec9fbb53f3e07e932b6&ascene=1&uin=MTc3NjA0ODMwMQ%3D%3D&devicetype=Windows+10+x64&version=62090538&lang=zh_CN&exportkey=A41kyUd%2FiVcTlZkqVyrG6Ys%3D&pass_ticket=GyGb6LDxaKbUL53v4EyXuyCHNDKoWPvH%2FOXwIE05nJiYKKHOraaEKGbr15GFLR3k&wx_header=0
    
    - https://blog.csdn.net/chenleiking/article/details/79453460
    
    - https://wayjam.me/posts/deploy-elasticsearch7-cluster-on-k8s/


- 碰上的坑：
    - 前两个是RancherLab上分享的，看了后，其yaml文件中没有selector属性，部署就直接报错；另外，其版本太旧了，镜像也没有说明。不过，里面的思想还是挺赞成的：
        - Elasticsearch分为三个角色，master/data/client。
        - Elasticsearch master节点Pods被部署为一个headless service的Replica Set，这将有助于自动发现。
        - Elasticsearch client节点Pods是以Replica Set的形式部署的，其内部服务将允许访问R/W请求的数据节点。
        - Elasticsearch data节点Pods被部署为一个有状态集（Stateful Set），并提供headless service，以提供稳定的Network Identity。
        
    - 后一个是另外的写法，比较贴进k8s上的部署逻辑，并且镜像也是使用的官网，比较容易接受。
    
    - 采用后者部署，很关注那个变量，因为两个作者的变量感觉很怪，怪是因为它不像zabbix镜像那里写得很清楚，看起来就很像和配置文件里的一样，索性就按着文章上先写，但是启动失败。之后，实在没办法，用虚拟机部署相同版本的集群是成功的，然后根据虚拟机上的配置文件中变量全写到yaml文件中，但是还是失败，试过加减不同的参数，但都是失败。
    
    - 关于变量为什么像配置文件中的，我是先进到了容器中，使用`ps -ef`查看进程才发现，那样是可以的，理由如下：
        ```shell
        [root@elasticsearch-master-76b5f648fc-cm6wq elasticsearch]# ps -ef | grep java
        elastic+      8      1  2 05:30 ?        00:02:25 /usr/share/elasticsearch/jdk/bin/java -Xshare:auto -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Djna.nosys=true -XX:-OmitStackTraceInFastThrow -XX:+ShowCodeDetailsInExceptionMessages -Dio.netty.noUnsafe=true -Dio.netty.noKeySetOptimization=true -Dio.netty.recycler.maxCapacityPerThread=0 -Dio.netty.allocator.numDirectArenas=0 -Dlog4j.shutdownHookEnabled=false -Dlog4j2.disable.jmx=true -Djava.locale.providers=SPI,COMPAT -Xms1g -Xmx1g -XX:+UseG1GC -XX:G1ReservePercent=25 -XX:InitiatingHeapOccupancyPercent=30 -Djava.io.tmpdir=/tmp/elasticsearch-3349398526245199070 -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=data -XX:ErrorFile=logs/hs_err_pid%p.log -Xlog:gc*,gc+age=trace,safepoint:file=logs/gc.log:utctime,pid,tags:filecount=32,filesize=64m -Des.cgroups.hierarchy.override=/ -Xms512m -Xmx512m -XX:MaxDirectMemorySize=268435456 -Des.path.home=/usr/share/elasticsearch -Des.path.conf=/usr/share/elasticsearch/config -Des.distribution.flavor=default -Des.distribution.type=docker -Des.bundled_jdk=true -cp /usr/share/elasticsearch/lib/* org.elasticsearch.bootstrap.Elasticsearch -Ecluster.initial_master_nodes=elasticsearch-master -Ediscovery.seed_hosts=elasticsearch-master
        root        233    223  0 06:55 pts/0    00:00:00 grep --color=auto java
        [root@elasticsearch-master-76b5f648fc-cm6wq elasticsearch]# 
        ```
    - 看到那个`-E`的大参数了吗？这个就是关键，同时我在虚拟机上查看了`elasticsearch`的能帮助就可以更加确定了。
        ```
        [root@node01.es.freedom.org /usr/share/elasticsearch/bin 14:59]# 28> ./elasticsearch -h
        Starts Elasticsearch
        
        Option                Description                                               
        ------                -----------                                               
        -E <KeyValuePair>     Configure a setting                                       
        -V, --version         Prints Elasticsearch version information and exits        
        -d, --daemonize       Starts Elasticsearch in the background                    
        -h, --help            Show help                                                 
        -p, --pidfile <Path>  Creates a pid file in the specified path on start         
        -q, --quiet           Turns off standard output/error streams logging in console
        -s, --silent          Show minimal output                                       
        -v, --verbose         Show verbose output                                       
        [root@node01.es.freedom.org /usr/share/elasticsearch/bin 15:00]# 29> 
        ```
    
    - 参数调整过程，最开始使用deployment模式部署，不成功；之后换成statefulset，也不行；配置参数不对，后索性使用configmap模式部署，也不行。其中还涉及到了`subPath`，最后失败。
    
    - 再调试，使用一个容器部署（此时，还是使用statefulset模式），什么参数也不加，结果报错，这说明了，elasticsearch启动时就需要配置参数，加上后成功；当部署到第三个，看日志有报错，参数设置不对，最后调整后就成功了。此时，`cluster.initial_master_nodes`参数还是stateful模式下的配置。
    
    - 再进行调整。此时，他是master模式，不进行任务数据存储，所以改回deployment部署。其实，statefulset和deployment两都都没有错，只是说deployment模式更加合理些（无状态本来使用这个是更合理，但是由于换了版本7后，就只能使用statefulset模式，2020/10/18）。
    
    - 2020/10/18，当使用版本`7`时，则要使用`statefulset`模式，这是因为配置参数有变化。当使用版本`6`时，可以使用`Deployment`模式部署。
    
    - 集群模式创建成功，日志如下：
        ```
        {"type": "server", "timestamp": "2020-10-18T14:59:33,922Z", "level": "INFO", "component": "o.e.x.s.s.SecurityStatusChangeListener", "cluster.name": "production-elasticsearch", "node.name": "elasticsearch-master-0", "message": "Active license is now [BASIC]; Security is disabled", "cluster.uuid": "F6TaYCs8QaSIzgFpYSU1ew", "node.id": "uj6QKreZQ1-Cx88PbJ9X_g"  }
        ```
        
- 总结：
    - elastic官网无说明，这个就真的很坑。就算是去官网看（`https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html`），那里只有针对`docker compose`的部署，不适合在k8s上部署。
    - 参考上面的文章，他们写的参数不适用，即使我把镜像版本换成和文章中的一样也不行，这个真的很崩溃。另外，根据虚拟机配置文件中的参数来写，这个也不行，这个就更加崩溃。最后是根据一个pod模式，增加到三个pod，通过查看日志最后得到解决。