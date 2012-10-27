#!/bin/bash

SERVICE_RATE="100 90 80 70 60 55 50 45 40 35 30 25 20 15 14 13 12 11 10"
ARRIVAL_RATE="1"
UNIT=000000
OUTPUT_PATH="/local2/thiagogenez/nqs/02/results"
SIMULATOR_PATH="../../nqs.py"
INPUT_TRACE="traffic_exercice2_sorted.in"




# If simulation_data directory exist, remove it 
if [ -d $OUTPUT_PATH ]; then
	echo "rm -rf $OUTPUT_PATH"
	rm -rf $OUTPUT_PATH

fi

# creating simulation_data directory
echo "mkdir $OUTPUT_PATH"
mkdir $OUTPUT_PATH

echo "Starting Execution..."



# For each service rate in SERVICE_RATES
for rate in $SERVICE_RATES; do
	echo "Simulation #$i with service rate $rate Gbits";
	python $SIMULATOR_PATH -i $INPUT_TRACE -o $OUTPUT_PATH/serviceRate-$rate-Mbit.out -s $rate$UNIT
done

echo "Simulations over!"
