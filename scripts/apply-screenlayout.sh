#!/bin/sh
intern=eDP-1
extern1=HDMI-1
extern2=DP-1

xrandr --output "$intern" --auto --pos 320x1440 --rotate "$1" --output "$extern1" --auto --pos 0x0 --output "$extern2" --auto --pos 0x0
feh --bg-fill ~/trentos/bg.jpg