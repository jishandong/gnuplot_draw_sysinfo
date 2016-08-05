#!/bin/bash

if [ $# -ne 1 ]
then
	echo "usage: ./draw.sh remote_ip"
	exit
fi
time=`date`
echo "$time: Begin drawing pics for $1..."
remote_ip=$1

##### make png dir ########
mkdir -p /tmp/$remote_ip


key=/home/qatest/scripts/perfcloud
scp -i $key -P 22 root@$remote_ip:/tmp/sysstat /tmp/$remote_ip/ > /dev/null
draw_file=/tmp/$remote_ip/sysstat

#echo $date $cpu_us $cpu_sy  $cpu_id $cpu_wa  $cpu_st $load_1 $load_5 $load_15 $mem_totle $mem_used $mem_util $con_nums

#echo "**********************************draw cpu info********************************"
gnuplot <<EOF
set terminal pngcairo lw 1
set output 'cpu_info.png'
set title 'cpu_info'
set xdata time
set timefmt '%Y-%m-%d/%H:%M:%S'
set xlabel 'time'
set ylabel 'util (%)'
set size ratio 0.5
plot "$draw_file" using 1:2 w l title "cpu_us",\
     "$draw_file" using 1:3 w l title "cpu_sy",\
     "$draw_file" using 1:4 w l title "cpu_id",\
     "$draw_file" using 1:5 w l title "cpu_wa",\
     "$draw_file" using 1:6 w l title "cpu_st"
set output 
EOF


#echo "************************************draw load info ***************************"
gnuplot <<EOF                                                                                    
set terminal pngcairo lw 1                                                                
set output 'load_info.png'                                                                 
set title 'load_info'                                                                      
set xdata time                                                                            
set timefmt '%Y-%m-%d/%H:%M:%S'                                                           
set xlabel 'time'                                                                         
set ylabel 'util (%)'                                                                     
set size ratio 0.5                                                                        
plot "$draw_file" using 1:7 w l title "load_1",\
     "$draw_file" using 1:8 w l title "load_5",\
     "$draw_file" using 1:9 w l title "load_15"                                            
set output                                                                                
EOF


#echo "****************************draw mem info ****************************"
gnuplot <<EOF
set terminal pngcairo lw 1
set output 'mem_info.png'
set title 'mem_info'
set xdata time
set timefmt '%Y-%m-%d/%H:%M:%S'
set xlabel 'time'
set ylabel 'Mem (MB)'
set size ratio 0.5
plot "$draw_file" using 1:11 w l title "mem_used"
set output 
EOF

#echo "**************************draw numbers of containers ******************"
gnuplot <<EOF                                                                                    
set terminal pngcairo lw 1                                                                
set output 'numbers_of_containers.png'                                                                 
set title 'containers_info'                                                                      
set xdata time                                                                            
set timefmt '%Y-%m-%d/%H:%M:%S'                                                           
set xlabel 'time'                                                                         
set ylabel 'util (%)'                                                                     
set size ratio 0.5                                                                        
plot "$draw_file" using 1:13 w l title "numbers of container"
set output                                                                                
EOF

cp cpu_info.png mem_info.png numbers_of_containers.png load_info.png /tmp/$remote_ip/
rm -rf cpu_info.png mem_info.png numbers_of_containers.png load_info.png

time=`date`
echo "$time: Finish drawing pics for $remote_ip..."
echo
echo "Visit http://115.236.124.215:8000/$remote_ip"
echo
