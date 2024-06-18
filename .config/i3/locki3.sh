#!/bin/sh

i3lock

xset dpms force standby

# wait until a key is pressed
while [ -z "$(xset q | grep 'Monitor is On')" ]; do
    sleep 1
done

# turn the screen back on
xset -dpms
