使用说明：
1. sysinfo.sh 负责节点上资源的收集 ，收集的信息存储到 /tmp/sysstat 文件中
   在节点上将该脚本添加到定时任务、或者利用watch定制采集信息的时间间隔即可
   eg：nohup watch -20 ./sysinfo.sh 每20秒采集一次数据
2. draw_whole_data.sh 在控制节点上执行，画出所有收集资源信息的曲线图
   eg：./draw_whole_data.sh 192.168.1.1
3. draw_period.sh 调用draw.sh 画出某个时间段内的资源数据图
   eg: ./draw_period.sh 192.168.1.1 "2016-08-05 03:00:26" "2016-08-05 08:01:11"
