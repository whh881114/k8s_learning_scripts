#/bin/sh

# rrqm/s:         每秒进行 merge 的读操作数目。即 delta(rmerge)/s
# wrqm/s:         每秒进行 merge 的写操作数目。即 delta(wmerge)/s
# rps:            每秒完成的读 I/O 设备次数。即 delta(rio)/s
# wps:            每秒完成的写 I/O 设备次数。即 delta(wio)/s
# rsec/s:         每秒读扇区数。即 delta(rsect)/s
# wsec/s:         每秒写扇区数。即 delta(wsect)/s
# rkBps:          每秒读K字节数。是 rsect/s 的一半，因为每扇区大小为512字节。(需要计算)
# wkBps:          每秒写K字节数。是 wsect/s 的一半。(需要计算)
# avgrq-sz:       平均每次设备I/O操作的数据大小 (扇区)。delta(rsect+wsect)/delta(rio+wio)
# avgqu-sz:       平均I/O队列长度。即 delta(aveq)/s/1000 (因为aveq的单位为毫秒)。
# await:          平均每次设备I/O操作的等待时间 (毫秒)。即 delta(ruse+wuse)/delta(rio+wio)
# svctm:          平均每次设备I/O操作的服务时间 (毫秒)。即 delta(use)/delta(rio+wio)
# %util:          一秒中有百分之多少的时间用于 I/O 操作，或者说一秒中有多少时间 I/O 队列是非空的。即 delta(use)/s/1000 (因为use的单位为毫秒)

Device=$1
METRIC=$2
case $METRIC in
         rrqm)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $2}'
            ;;
         wrqm)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $3}'
            ;;
          rps)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $4}'
            ;;
          wps)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $5}'
            ;;
        rKBps)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $6}'
            ;;
        wKBps)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $7}'
            ;;
        avgrq-sz)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $8}'
            ;;
        avgqu-sz)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $9}'
            ;;
        await)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $10}'
            ;;
        r_await)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $11}'
            ;;
        w_await)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $12}'
            ;;
        svctm)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $13}'
            ;;
        util)
            iostat -dxkt | grep "\b$Device\b" | awk '{print $14}'
            ;;
esac