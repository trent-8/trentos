#!/bin/sh
intern=eDP-1
extern1=HDMI-1
extern2=DP-1

xrandr --output "$intern" --auto --rotate "$1" --output "$extern1" --auto --above "$intern" --output "$extern2" --auto --above "$intern"
feh --bg-fill ~/trentos/bg.jpg