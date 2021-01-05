#!/bin/bash
#this script is used to get tcp and udp connetion status
#tcp status

# ESTABLISHED       socket已经建立连接
# CLOSED            socket没有被使用，无连接
# CLOSING           服务器端和客户端都同时关闭连接
# CLOSE_WAIT        等待关闭连接
# TIME_WAIT         表示收到了对方的FIN报文，并发送出了ACK报文，等待2MSL后就可回到CLOSED状态
# LAST_ACK          远端关闭，当前socket被动关闭后发送FIN报文，等待对方ACK报文
# LISTEN            监听状态
# SYN_RECV          接收到SYN报文
# SYN_SENT          已经发送SYN报文
# FIN_WAIT1         The socket is closed, and the connection is shutting down
# FIN_WAIT2         Connection is closed, and the socket is waiting for a shutdown from the remote end.

# 修改者：汪浩浩
# 时间：2020/11/7
# 说明：
#   1- 使用ss替换netstat命令。
#   2- All standard TCP states: established, syn-sent, syn-recv, fin-wait-1, fin-wait-2, time-wait, closed, close-wait, last-ack, listen and closing.

metric=$1
output=`ss -o state -t $metric 2>/dev/null | wc | awk '{print $1}'`
echo $output
