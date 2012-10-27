#coding: utf-8

import random,sys,math
import logging
from config import *

__all__ = ['generate']

def exponential (mean):
	return (-mean * math.log(random.random()))
	#return (random.expovariate(1.0/mean))

def getPacketSize ():	
	packetSize = int(exponential(AVERAGE_PACKET_SIZE))
	while (packetSize < MIN_PACKET_SIZE) or (packetSize > MAX_PACKET_SIZE):
		packetSize = int(exponential(AVERAGE_PACKET_SIZE))

	return packetSize

def getArrivalTime(arrivalRate):
	return exponential(( AVERAGE_PACKET_SIZE * 8)/arrivalRate)

def generate(filename,simulationTime, arrivalRate):
	try:
		with open(filename,'w') as file_in:
			time = 0.0
			while time <= simulationTime:
				time += getArrivalTime(arrivalRate)
				packetSize = getPacketSize()
					
				file_in.write("%s \t %s\n" % (time,packetSize))

	except IOError as ioerr:
		logging.exception('File creation error: IOError: '+str(ioerr))
