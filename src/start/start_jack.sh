#!/bin/bash

DEVICE=hw:USB

#JACKOPTIONS="--realtime"
ALSAOPTIONS="-n2"

# general:
# -R, --realtime
# alsa:
# -n2, --nperiods
# -s, --softmode

# sample rate
RATE=48000
BLOCKSIZE=1024

#jackd -d dummy -r $RATE -p $BLOCKSIZE -C 64 -P 64 &

jackd $JACKOPTIONS -d alsa -r$RATE -p$BLOCKSIZE -d$DEVICE $ALSAOPTIONS &

# start control panel to check the input-output connections
qjackctl &
