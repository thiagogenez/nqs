#!/bin/bash

SERVICE_RATES="100 90 80 70 60 55 50 45 40 35 30 25 20 15 14 13 12 11 10"
ARRIVAL_RATE="10"
UNIT=000000
AMOUNT_OF_SIMULATION=30
OUTPUT_PATH="/local2/thiagogenez/nqs/01/results"
SIMULATOR_PATH="../../nqs.py"




# If simulation_data directory exist, remove it 
if [ -d $OUTPUT_PATH ]; then
	echo "rm -rf $OUTPUT_PATH"
	rm -rf $OUTPUT_PATH

fi

# creating simulation_data directory
echo "mkdir $OUTPUT_PATH"
mkdir $OUTPUT_PATH

echo "Starting Execution..."

# Running nqs simulator with diferent traffic values
for i in $(seq 1 $AMOUNT_OF_SIMULATION); do
	echo "Simulation with traffic file $i";
	
	# For each service rate in SERVICE_RATES
    	for rate in $SERVICE_RATES; do
		echo "Simulation #$i with service rate $rate Mbit/s";
		if [ $rate -eq 100 ]; then
			# Generates a queue trace file for each service rate cicle
			python $SIMULATOR_PATH -o $OUTPUT_PATH/$i-serviceRate-$rate-Mbit-$ARRIVAL_RATE-Mbit.out -s $rate$UNIT -a $ARRIVAL_RATE$UNIT

		else		
			python $SIMULATOR_PATH -o $OUTPUT_PATH/$i-serviceRate-$rate-Mbit-$ARRIVAL_RATE-Mbit.out -s $rate$UNIT -i $OUTPUT_PATH/traffic.trace
		fi	
	done
	mv $OUTPUT_PATH/traffic.trace $OUTPUT_PATH/$i-traffic.trace
done

echo "Simulations over!"
