#!/bin/bash

# Define a function to get the current brightness
get_current_brightness() {
    brillo -G
}

# Check the argument and adjust brightness accordingly
if [ "$1" = "up" ]; then
    # Increase brightness
    brillo -q -u 300000 -A 5
elif [ "$1" = "down" ]; then
    # Decrease brightness
    brillo -q -u 300000 -U 5
else
    echo "Invalid argument: Use 'up' to increase or 'down' to decrease brightness."
    exit 1
fi

# Get the current brightness level
current_brightness=$(get_current_brightness)

# Display the notification
notify-send "Brightness Adjustment" "Current Brightness: $current_brightness%"
