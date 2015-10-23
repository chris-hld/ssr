#!/bin/bash

# clean up
./start/kill_all.sh

# jack
./start/start_jack.sh
sleep 4


# SSR
./start/start_ssr.sh
sleep 10

# Connect BRS outputs
./start/connect_channels.sh
