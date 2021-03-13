#!/usr/bin/perl

# 分析k8s集群中各个pod的java进程的xmx的参数。
# 文件结构为：
# POD: xxxx/xxx-xxxxx
# JAVA进程信息1条
# JAVA进程信息1条
# ...
# JAVA进程信息N条
# POD: xxxx/xxx-xxxxx
# JAVA进程信息1条

$k8s_xmx = $ARGV[0];

open(DATA, $k8s_xmx) || die "Can't open file: $!\n";

while(<DATA>)
{
    if(/^POD:\s+(.*)\/(.*)$/)
    {
        $namespace = $1;
        $pod = $2;
        $start = 1;
        $end = 1;
    }
    else
    {
        if(/\-(Xmx[^ ]*)/)
        {
            $xmx_hash{uc($1)}++;
        }
        $end = 0;
        $tmp_namespace = $namespace;
        $tmp_pod = $pod;
    }

    if($start == 1 and $end == 1)
    {
        # 打印结果
        if($tmp_namespace and $tmp_pod)
        {
            printf("NAMESPACE:%-30s POD:%-50s JVM:", $tmp_namespace, $tmp_pod);
            while(($key, $value) = each(%xmx_hash))
            {
                printf("{SIZE: %s, COUNT: %d} ", $key, $value);
            }
            # 初始化xmx统计结果。
            %xmx_hash = ();
            print("\n");
        }
    }

}

close(DATA);
