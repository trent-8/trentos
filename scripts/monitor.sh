#!/bin/sh
intern=eDP-1
extern1=HDMI-1
extern2=DP-1

if xrandr | grep "$extern1 disconnected" ; then
    if xrandr | grep "$extern2 disconnected" ; then
        xrandr --output "$extern1" --off --output "$extern2" --off --output "$intern" --auto
    else
        xrandr --output "$intern" --off --output "$extern1" --auto --output "$extern2" --auto
    fi
else
    xrandr --output "$intern" --off --output "$extern1" --auto --output "$extern2" --auto
fi