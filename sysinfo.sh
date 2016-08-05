#!/bin/bash
date=`date +'%Y-%m-%d/%H:%M:%S'`
# cpu info
top_info=`top -b -n 1 | head -n 3 | grep Cpu`
load_info=`uptime`
mem_info=`free -m | grep Mem`
con_nums=`docker ps -aq | wc -l`

cpu_us=`echo $top_info| awk -F, '{print $1}'| awk -F: '{print $2}'|awk '{print $1}'`
cpu_sy=`echo $top_info| awk -F, '{print $2}'|awk  '{print $1}'`
#cpu_ni=`echo $top_info| awk -F, '{print $3}'|awk  '{print $2}'`
cpu_id=`echo $top_info| awk -F, '{print $4}'|awk  '{print $1}'`
cpu_wa=`echo $top_info| awk -F, '{print $5}'|awk  '{print $1}'`
#cpu_hi=`echo $top_info| awk -F, '{print $6}'|awk  '{print $2}'`
#cpu_si=`echo $top_info| grep Cpu | awk -F, '{print $7}'|awk '{print $2}'`
cpu_st=`echo $top_info| grep Cpu | awk -F, '{print $8}'|awk '{print $1}'`
 
# load info
#load_info=`top -b -n 1| head -n 1`
load_1=`echo $load_info| awk -F, '{print $4}' | awk -F: '{print $2}'`
load_5=`echo $load_info| awk -F, '{print $5}'`
load_15=`echo $load_info| awk -F, '{print $6}'`
 
# memory info
scale=3
#mem_info=`free -m | grep Mem`
mem_totle=`echo $mem_info|awk -F: '{print $2}'| awk '{print $1}'`
mem_used=`echo $mem_info|awk -F: '{print $2}'| awk '{print $2}'`
mem_util=`echo "scale=2;$mem_used / $mem_totle " | bc | awk '{printf"%.2f", $0}'`
#mem_util=`echo ${mem_util1}${util}` 
 
# number of containers
#con_nums=`docker ps -aq | wc -l`
#printf "%-20s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s\n" $date $cpu_us $cpu_sy $cpu_ni $cpu_id $cpu_wa $cpu_hi $cpu_si $cpu_st $load_1 $load_5 $load_15 $mem_totle $mem_used $mem_util $con_nums >>info
     
#echo $date $cpu_us $cpu_sy $cpu_ni $cpu_id $cpu_wa $cpu_hi $cpu_si $cpu_st $load_1 $load_5 $load_15 $mem_totle $mem_used $mem_util $con_nums >>/tmp/sysstat
echo $date $cpu_us $cpu_sy  $cpu_id $cpu_wa  $cpu_st $load_1 $load_5 $load_15 $mem_totle $mem_used $mem_util $con_nums >>/tmp/sysstat

                                                                                                                                                                
