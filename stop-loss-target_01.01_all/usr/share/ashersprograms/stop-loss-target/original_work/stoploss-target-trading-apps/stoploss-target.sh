#!/bin/bash

# Get the script directory
script_dir=$(dirname "$(readlink -f "$0")")
command_to_run="$script_dir/$(basename "$0")"

# Define the desired keyboard shortcut (Ctrl+Alt+Z)
shortcut_key="<Primary><Alt>Z"

# Create an application shortcut with Ctrl+Alt+Z key combination
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/$shortcut_key" -n -t string -s "$command_to_run"

# Function to calculate stop loss and target based on points
calculate_stoploss_target() {
    local buy_price=$1
    local stop_loss_points=$2
    local target_points=$3

    stop_loss_price=$(echo "scale=4; $buy_price - $stop_loss_points" | bc)
    target_price=$(echo "scale=4; $buy_price + $target_points" | bc)

    echo "Buy: $buy_price"
    echo "Stop Loss: $stop_loss_price"
    echo "Target: $target_price"
}

# Prompt user for buy price, stop loss points, and target points
buy_price=$(zenity --entry --title="Stop Loss and Target Calculator" --text="Enter Buy Price:")
stop_loss_points=$(zenity --entry --title="Stop Loss and Target Calculator" --text="Enter Stop Loss Points:")
target_points=$(zenity --entry --title="Stop Loss and Target Calculator" --text="Enter Target Points:")

# Check if user cancels any input
if [ -z "$buy_price" ] || [ -z "$stop_loss_points" ] || [ -z "$target_points" ]; then
    zenity --error --text="Input canceled. Please enter all values."
    exit 1
fi

# Calculate stop loss and target prices
result=$(calculate_stoploss_target "$buy_price" "$stop_loss_points" "$target_points")

# Save the calculation result with heading and underline to a file
{
    echo "Trade Information"
    echo "-----------------"
    echo "$result"
} > ~/.conky/NeatInfo/addons/note.txt

# Display the calculation result to the user
zenity --info --title="Stop Loss and Target Calculator Result" --text="$result" --width=400

exit 0
