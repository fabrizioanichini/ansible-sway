#!/bin/bash

# Check if HDMI (DP-4) is connected
if swaymsg -t get_outputs | grep -q "DP-4.*connected"; then
    swaymsg output eDP-1 disable
else
    swaymsg output eDP-1 enable
fi

