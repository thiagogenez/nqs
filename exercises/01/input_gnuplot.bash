#!/bin/bash


SERVICE_RATES="100 95 90 85 80 75 70 65 60 55 50 45 40 35 30 25 20 15 14 13 12 11 10"
OUTPUT_PATH="/local2/thiagogenez/nqs/01/results"
DATA="Utilization Mean-delay Mean-queue-length"

if [ -d $OUTPUT_PATH/gnuplot ]; then
	rm -rf $OUTPUT_PATH/gnuplot
fi
mkdir $OUTPUT_PATH/gnuplot


for rate in $SERVICE_RATES; do
	array=()
	i=0
	for data in ; do
		array[i]=`cat $OUTPUT_PATH/*serviceRate-$rate-Mbit* | grep "$data" | awk -F " " {'print $5'} | awk '{sum+=$1; sumsq+=$1*$1;} END {avg=sum/NR; std=sqrt(sumsq/NR - avg^2); ci95=(1.96 * std)/sqrt(NR); printf "%.12f %.12f %.12f %.12f %.12f\n", avg, std, ci95, avg-ci95, avg+ci95}' | awk '{print $1, $3}'` 
		((i++))
	done
	#txt=`echo ${array[0]} | awk 'print $1'`
	#txt+=" `echo ${array[1]}` `echo ${array[2]}`" 
	echo "`echo ${array[0]} | awk '{print $1}'` `echo ${array[1]}`" >> $OUTPUT_PATH/gnuplot/`echo ${DATA[1]} | tr "[:upper:]" "[:lower:]"`.plot 
	echo "`echo ${array[0]} | awk '{print $1}'` `echo ${array[2]}`" >> $OUTPUT_PATH/gnuplot/`echo ${DATA[2]} | tr "[:upper:]" "[:lower:]"`.plot 
done



