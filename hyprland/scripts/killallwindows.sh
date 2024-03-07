#!/usr/bin/env sh

# Get a list of all valid PIDs (not negative numbers) from hyprctl clients
pids=$(hyprctl clients | grep 'pid:' | awk '{print $2}' | grep -v -E '^-1$')

# Loop through each PID and kill it
for pid in $pids; do
    kill $pid
done
