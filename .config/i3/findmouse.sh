#!/bin/bash

DEVICE_ID=$(xinput list | grep "Logitech Wireless Mouse MX Master" | sed -n "s/.*id=\([0-9]\+\).*/\1/p")

if [ -n "$DEVICE_ID" ]; then
    xinput --set-prop "$DEVICE_ID" "libinput Accel Speed" -0.7
else
    echo "Mouse not found"
fi
