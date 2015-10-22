#!/bin/bash

VOLUME=20000

CONFFILE=./config/ssr_brs.conf

WORKING_DIR=$(pwd)

setvolume.sh $VOLUME

ssr-brs \
    -c $WORKING_DIR/$CONFFILE $SSROPTIONS &
# Store PID of SSR in order to stop it from a script
echo $! > pid.tmp