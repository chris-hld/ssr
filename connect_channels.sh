#!/bin/bash
# First disconnect all standard Jack and SSR channels.
# Then connect jack outputs to SSR inputs and the SSR Output to 
# System outputs channels 63,64 used for headphones/ 64 for Subwoofer,
# Also correcting the SSR Feed No. according to Channel No. by offset -10.
# AUTHOR: Hagen Wierstorf, Chris Hold

sleep 10

SSR_TYPE=WFS-Renderer
SYS=system

#jack_disconnect system:capture_1 WFS-Renderer:in_1

for (( i=1; i<=52; i++))
do
	jack_disconnect $SYS:capture_$i $SSR_TYPE:in_$i
done


# connect Sys channels 11..32 to SSR but correct channel no.
for (( i=1; i<=52; i++))
do
	j=`expr $i + 10`
	jack_connect $SYS:capture_$j  $SSR_TYPE:in_$i
done

# connect SSR Output to the sysoutput channels 63 and 64, Subwoofer
jack_connect $SSR_TYPE:out_63 $SYS:playback_63
jack_connect $SSR_TYPE:out_64 $SYS:playback_64
