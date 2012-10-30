#!/bin/bash

UNIT=000000
SIMULATION_NUMBER=01
SERVICE_RATES=($(seq -f "%.0f" `echo "100$UNIT -5$UNIT 10$UNIT"`))
SERVICE_RATES[${#SERVICE_RATES[@]}+1]=9500000
SERVICE_RATES[${#SERVICE_RATES[@]}+1]=9000000
ARRIVAL_RATE="10"
AMOUNT_OF_SIMULATION=50
OUTPUT_PATH="/local2/thiagogenez/nqs/$SIMULATION_NUMBER/results"
SIMULATOR_PATH="../../nqs.py"

# If simulation_data directory exist, remove it 
if [ -d $OUTPUT_PATH ]; then
	echo "rm -rf $OUTPUT_PATH"
	rm -rf $OUTPUT_PATH

fi

# creating simulation_data directory
echo "mkdir $OUTPUT_PATH"
mkdir $OUTPUT_PATH

echo "Starting simulation..."

# Running nqs simulator with diferent traffic values
for i in $(seq 1 $AMOUNT_OF_SIMULATION); do
	#echo "Simulation with traffic file $i";
	
	# For each service rate in SERVICE_RATES
    	for rate in ${SERVICE_RATES[@]}; do
		echo "Simulation #$i with service rate $rate Mbit/s";
		#if [ $rate -eq 100 ]; then
			# Generates a queue trace file for each service rate cicle
			python $SIMULATOR_PATH -o $OUTPUT_PATH/$i-serviceRate-$rate-Mbps-$ARRIVAL_RATE-Mbps.out -s $rate -a $ARRIVAL_RATE

		#else		
		#	python $SIMULATOR_PATH -o $OUTPUT_PATH/$i-serviceRate-$rate-Mbps-$ARRIVAL_RATE-Mbps.out -s $rate -i $OUTPUT_PATH/traffic.trace
		#fi	
	done
	mv $OUTPUT_PATH/traffic.trace $OUTPUT_PATH/$i-traffic.trace
done

echo "Simulaton was finished.."

echo "Creating .plot files for  gnuplot...";
./input_gnuplot.bash $OUTPUT_PATH $SERVICE_RATES
echo ".plot files was created..."


echo "Creating .eps files..."
./plot $OUTPUT_PATH
echo ".eps files was created..."