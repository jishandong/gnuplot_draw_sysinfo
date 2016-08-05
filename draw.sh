#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 remote_ip data_file"
	exit
fi


#echo $date $cpu_us $cpu_sy  $cpu_id $cpu_wa  $cpu_st $load_1 $load_5 $load_15 $mem_totle $mem_used $mem_util $con_nums
ip=$1
file=$2

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
plot "$file" using 1:2 w l title "cpu_us",\
     "$file" using 1:3 w l title "cpu_sy",\
     "$file" using 1:4 w l title "cpu_id",\
     "$file" using 1:5 w l title "cpu_wa",\
     "$file" using 1:6 w l title "cpu_st"
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
plot "$file" using 1:7 w l title "load_1",\
     "$file" using 1:8 w l title "load_5",\
     "$file" using 1:9 w l title "load_15"                                            
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
plot "$file" using 1:11 w l title "mem_used"
set output 
EOF

# echo "**************************draw numbers of containers ******************"
gnuplot <<EOF                                                                                    
set terminal pngcairo lw 1                                                                
set output 'numbers_of_containers.png'                                                                 
set title 'containers_info'                                                                      
set xdata time                                                                            
set timefmt '%Y-%m-%d/%H:%M:%S'                                                           
set xlabel 'time'                                                                         
set ylabel 'util (%)'                                                                     
set size ratio 0.5                                                                        
plot "$file" using 1:13 w l title "numbers of container"
set output                                                                                
EOF

cp cpu_info.png mem_info.png numbers_of_containers.png load_info.png /tmp/$ip/
rm -rf cpu_info.png mem_info.png numbers_of_containers.png load_info.png 
