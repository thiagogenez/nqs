#!/bin/bash

SERVICE_RATES="100 90 80 70 60 50 45 40 35 30 25 20 15 10 5 4 3 2 1"
ARRIVAL_RATE="1"
UNIT=000000000
AMOUNT_OF_SIMULATION=30
OUTPUT_PATH="/local2/thiagogenez/nqs/results"
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

# Running nqs simulator  with diferent traffic values
for i in $(seq 1 $AMOUNT_OF_SIMULATION); do

    # For each service rate in SERVICE_RATES
    for rate in $SERVICE_RATES; do
    	echo "Simulation #$i with service rate $rate Gbits";
    	python $SIMULATOR_PATH -o $OUTPUT_PATH/$i-$rate-Gb-$ARRIVAL_RATE-Gb.out -s $rate$UNIT -a $ARRIVAL_RATE$UNIT    
    done

done
