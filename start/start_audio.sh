#!/bin/bash

# clean up
./start/kill_all.sh

# jack
./start/start_jack.sh
sleep 4


# SSR
./start/start_ssr.sh & ./start/connect_channels.sh
sleep 8

# Connect SSR outputs
#./start/connect_channels.sh
