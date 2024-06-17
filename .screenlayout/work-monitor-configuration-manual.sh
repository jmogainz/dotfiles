#!/bin/sh
xrandr --output DP-4 --auto --output HDMI-1-0 --auto --left-of DP-4
xrandr --output eDP-1 --off
xrandr --output DP-4 --auto --output DP-1-0.5.5 --auto --left-of DP-4
xrandr --output DP-1-0.5.5 --auto --output DP-1-0.6.6 --auto --left-of DP-1-0.5.5
