#!/bin/bash

# clean up
./kill_all.sh

# jack
./start_jack.sh
sleep 4


# SSR
./start_ssr.sh & ./connect_channels.sh
sleep 8

# Connect SSR outputs
#./start/connect_channels.sh
