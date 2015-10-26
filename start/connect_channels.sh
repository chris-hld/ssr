#!/bin/bash
# First disconnect all standard Jack and SSR channels.
# Then connect jack outputs to SSR inputs and the SSR Output to 
# System outputs channels 63,64 used for headphones/ 64 for Subwoofer,
# Also correcting the SSR Feed No. according to Channel No. by offset -10.
# AUTHOR: Hagen Wierstorf, Chris Hold

SSR_TYPE=WFSRenderer
SYS=system
#PD=pure_data_0

# disconnect all standard connections
jack_disconnect $SSR_TYPE:out_1  $SYS:playback_1
jack_disconnect $SSR_TYPE:out_2  $SYS:playback_2

jack_disconnect $SYS:capture_1  $PD:input0
jack_disconnect $SYS:capture_2  $PD:input1

for (( i=0; i<=31; i++))
do
	j=`expr $i + 1`
	jack_disconnect $PD:output$i  $SYS:playback_$j
done

# connect PD channels 1..30 to SSR
for (( i=0; i<=30; i++))
do
	jack_connect $PD:output$i  $SSR_TYPE:in_$i
done

# connect SSR Output to the sysoutput channels 1 and 2
#jack_connect $BRS:out_1 $SYS:playback_1
#jack_connect $BRS:out_2 $SYS:playback_2

# connect SSR Output to the sysoutput channels 63 and 64
jack_connect $SSR_TYPE:out_1 $SYS:playback_63
jack_connect $SSR_TYPE:out_2 $SYS:playback_64
