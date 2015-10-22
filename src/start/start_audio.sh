#!/bin/bash

# clean up
./kill_all.sh

# jack
./start_jack.sh
sleep 4

# PD
./start_pd.sh
sleep 10

# SSR
./start_ssr.sh
sleep 10

# Connect BRS outputs
./connect_channels.sh
