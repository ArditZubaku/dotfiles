#!/bin/bash
# focus_under_mouse.sh

# Get the window ID under the mouse
WIN_ID=$(xdotool getmouselocation --shell | grep WINDOW | cut -d= -f2)

# Focus the window if it's not null or empty
if [ -n "$WIN_ID" ] && [ "$WIN_ID" != "0" ]; then
    xdotool windowfocus "$WIN_ID"
fi
