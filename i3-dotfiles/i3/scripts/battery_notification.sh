#!/bin/bash

while true; do
    # Get the battery status
    battery_status=$(acpi -b | awk '{print $3}' | tr -d ',')

    # Extract the battery percentage
    battery_percentage=$(acpi -b | grep -P -o '[0-9]+(?=%)')

    # Check if battery percentage is less than 20%
    if [ "$battery_status" == "Discharging" ] && [ "$battery_percentage" -lt 20 ]; then
        notify-send "Low Battery" "Battery is at $battery_percentage%." --urgency=normal
    fi

    # Sleep for 1 minute before checking again
    sleep 60
done
