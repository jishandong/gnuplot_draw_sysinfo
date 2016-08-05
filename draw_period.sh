#!/bin/bash
#可以匹配到分钟级别，画图

if [ $# -ne 3 ]
then
	echo "usage: $0 remote_ip start_time end_time"
	exit
fi
#拷贝远程主机上的数据
remote_ip=$1
time=`date`
echo "$time: Begin drawing pics for $remote_ip..."
mkdir -p /tmp/$remote_ip

key=/home/qatest/scripts/perfcloud

scp -i $key -P 22 root@$remote_ip:/tmp/sysstat /tmp/$remote_ip/

#获取时间段
start=$2
end=$3
Y1=`echo "$2" | awk '{print $1}'`
H1=`echo "$2" | awk '{print $2}' | cut -d : -f 1-2`
Y2=`echo "$3" | awk '{print $1}'`
H2=`echo "$3" | awk '{print $2}' | cut -d : -f 1-2`
new_start_time=`echo $Y1"\\/"$H1`
new_end_time=`echo $Y2"\\/"$H2`

#获取时间段内的数据


cat /tmp/$remote_ip/sysstat |sed "/$new_start_time/,/$new_end_time/!d" > /tmp/$remote_ip/sysstat_new

./draw.sh $remote_ip /tmp/$remote_ip/sysstat_new 

time=`date`
echo "$time: Finish drawing pics for $remote_ip..."
echo
echo "Visit http://115.236.124.215:8000/$remote_ip"
echo
