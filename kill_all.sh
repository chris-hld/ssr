#!/bin/sh

# first, try it nicely, then show no mercy ...

for SIGNAL in SIGTERM SIGKILL
do
	killall -s $SIGNAL pd-gui
	killall -s $SIGNAL pd
	killall -s $SIGNAL meterbridge
	killall -s $SIGNAL ssr
	killall -s $SIGNAL ecasound
	killall -s $SIGNAL qjackctl
	killall -s $SIGNAL jackd

	sleep 1
done
