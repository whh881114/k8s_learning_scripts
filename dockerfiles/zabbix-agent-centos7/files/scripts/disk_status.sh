#!/bin/bash

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


# [root@master01.k8s.freedom.org ~ 20:19]# 16> iostat -xmt
# Linux 3.10.0-1062.el7.x86_64 (master01.k8s.freedom.org)         05/29/2021      _x86_64_        (8 CPU)
#
# 05/29/2021 08:19:29 PM
# avg-cpu:  %user   %nice %system %iowait  %steal   %idle
#           12.65    0.01    6.80    5.22    0.00   75.32
#
# Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
# sda               0.48     0.27  139.55   35.69    26.22     0.27   309.61     4.62   26.26   32.72    0.97   5.13  89.98
# dm-0              0.00     0.00  140.90   35.96    26.22     0.27   306.75     4.72   26.40   32.89    0.98   5.11  90.43
#
# [root@master01.k8s.freedom.org ~ 20:19]# 17> 


Device=$1
METRIC=$2
case $METRIC in
         rrqm/s)
            iostat -xmt | grep "\b$Device\b" | awk '{print $2}'
            ;;
         wrqm/s)
            iostat -xmt | grep "\b$Device\b" | awk '{print $3}'
            ;;
          r/s)
            iostat -xmt | grep "\b$Device\b" | awk '{print $4}'
            ;;
          w/s)
            iostat -xmt | grep "\b$Device\b" | awk '{print $5}'
            ;;
        rMB/s)
            iostat -xmt | grep "\b$Device\b" | awk '{print $6}'
            ;;
        wMB/s)
            iostat -xmt | grep "\b$Device\b" | awk '{print $7}'
            ;;
        avgrq-sz)
            iostat -xmt | grep "\b$Device\b" | awk '{print $8}'
            ;;
        avgqu-sz)
            iostat -xmt | grep "\b$Device\b" | awk '{print $9}'
            ;;
        await)
            iostat -xmt | grep "\b$Device\b" | awk '{print $10}'
            ;;
        r_await)
            iostat -xmt | grep "\b$Device\b" | awk '{print $11}'
            ;;
        w_await)
            iostat -xmt | grep "\b$Device\b" | awk '{print $12}'
            ;;
        svctm)
            iostat -xmt | grep "\b$Device\b" | awk '{print $13}'
            ;;
        %util)
            iostat -xmt | grep "\b$Device\b" | awk '{print $14}'
            ;;
esac