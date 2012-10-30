#!/bin/bash


OUTPUT_PATH=$1


DATA=('Mean-delay' 'Mean-queue-length')

if [ -d $OUTPUT_PATH/eps ]; then
	rm -rf $OUTPUT_PATH/eps
fi
mkdir $OUTPUT_PATH/eps

for data in ${DATA[@]}; do

	gnuplot << EOF
		reset
		set encoding utf8
		set   autoscale           # scale axes automatically
		unset log                 # remove any log-scaling
		unset label               # remove any previous labels

		set mytics
		set style data linespoints
		set xlabel "Utilização"
		set ylabel "Atraso médio"
		set title "Utilização x Atraso médio"

		set key left top
		set term postscript enhanced eps dashed lw 1 "Helvetica" 14
		set output "$OUTPUT_PATH/eps/`echo $data | tr "[:upper:]" "[:lower:]"`.eps"

		plot "$OUTPUT_PATH/gnuplot/`echo $data | tr "[:upper:]" "[:lower:]"`.plot"  using 1:2:3 title "Mean Delay" with yerrorlines pointtype 12
EOF

done
