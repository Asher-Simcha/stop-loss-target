#!/bin/bash
# Title: Stop Loss Target
# Author: Asher Simcha
# _____/\\\\\\\\\________/\\\\\\\\\\\____/\\\________/\\\__/\\\\\\\\\\\\\\\____/\\\\\\\\\_____        
#  ___/\\\\\\\\\\\\\____/\\\/////////\\\_\/\\\_______\/\\\_\/\\\///////////___/\\\///////\\\___       
#   __/\\\/////////\\\__\//\\\______\///__\/\\\_______\/\\\_\/\\\_____________\/\\\_____\/\\\___      
#    _\/\\\_______\/\\\___\////\\\_________\/\\\\\\\\\\\\\\\_\/\\\\\\\\\\\_____\/\\\\\\\\\\\/____     
#     _\/\\\\\\\\\\\\\\\______\////\\\______\/\\\/////////\\\_\/\\\///////______\/\\\//////\\\____    
#      _\/\\\/////////\\\_________\////\\\___\/\\\_______\/\\\_\/\\\_____________\/\\\____\//\\\___   
#       _\/\\\_______\/\\\__/\\\______\//\\\__\/\\\_______\/\\\_\/\\\_____________\/\\\_____\//\\\__  
#        _\/\\\_______\/\\\_\///\\\\\\\\\\\/___\/\\\_______\/\\\_\/\\\\\\\\\\\\\\\_\/\\\______\//\\\_ 
#         _\///________\///____\///////////_____\///________\///__\///////////////__\///________\///__2024
# Additional Authors: Somen Bhattacharjee
# Additional Authors: 
# Filename: stop-loss-target
# Description: Day Traders, Stop-Loss-Target.
# Additional_Notes: 
# Version: 1
# Date: 01-16-2023
# Last_Modified: 01-17-2023
# Source: 
# Additional_Sources: 
# License: MIT
# Additional_Licenses: Original License by Somen Bhattacharjee MIT.
# Credits: 
# Additional Credits: 
# Additional Credits: 
# Audio_Location: 
# Location_of_the_Video: 
# Embed_YouTube: 
# Website_For_Video: 
# Start_Time: 
# Parent_File: 
# Sibling_File: /usr/share/icons/Tango/scalable/emotes/face-smile.svg
# Sibling_File: /usr/share/icons/stop-loss-target.png
# Child_File: 
# Child_File: 
# Linkable: 1
# Display_Links: 1
# Display_Code: 1
# Visible: 1
# Article: 

# MIT License
# 
# Copyright (c) 2023 Asher Simcha
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Original License can be found at /usr/share/ashersprograms/stop-loss-target/original_work

# Create the directories needed to save the file
SAVE_FILE=1 # 1 Equals Save the file 0 Equals DON'T Save the file.

# Get the script directory
script_dir=$(dirname "$(readlink -f "$0")")
command_to_run="$script_dir/$(basename "$0")"

# Information about where to copy the file.
CONKY_DIR="$HOME/.conky"
NEAT_DIR=$CONKY_DIR"/NeatInfo"
ADDON_DIR=$NEAT_DIR"/addons"
FILE="$ADDON_DIR/note.txt"

# Define the desired keyboard shortcut (Ctrl+Alt+Z)
shortcut_key="<Primary><Alt>Z"

# Create an application shortcut with Ctrl+Alt+Z key combination
#xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/$shortcut_key" -n -t string -s "$command_to_run"

# Function to calculate stop loss and target based on points
calculate_stoploss_target() {
    local buy_price=$1
    local stop_loss_points=$2
    local target_points=$3

    stop_loss_price=$(echo "scale=4; $buy_price - $stop_loss_points" | bc)
    target_price=$(echo "scale=4; $buy_price + $target_points" | bc)
    output="Buy: $buy_price\n"
    output=$output"Stop Loss: $stop_loss_price\n"
    output=$output"Target: $target_price\n"
    echo $output
}

# Prompt user for buy price, stop loss points, and target points
YADRESULTS=$(yad --form \
--window-icon="/usr/share/icons/stop-loss-target.png" \
--title="Stop Loss and Target Calculator" \
--width="400" \
--image="/usr/share/icons/Tango/scalable/emotes/face-smile.svg" \
--field="Enter Buy Price:" \
--field="Enter Stop Loss Points:" \
--field="Enter Target Points:")
RESULTS=$?
if [ $RESULTS -eq "1" ]; then
    exit 1;
fi
# change | to space
YADRESULTS=$(echo "$YADRESULTS" | sed 's/|/ /g' )
# -f change the delimiter to a space and get the first field
buy_price=$(echo $YADRESULTS | awk -F" " '{print $1}')
# -f change the delimiter to a space and get the second field
stop_loss_points=$(echo $YADRESULTS | awk -F" " '{print $2}')
# -f change the delimiter to a space and get the third field
target_points=$(echo $YADRESULTS | awk -F" " '{print $3}')

# Calculate stop loss and target prices
result=$(calculate_stoploss_target "$buy_price" "$stop_loss_points" "$target_points")

resultPrint=$result"\nClick Ok to Save to File.\n"

# Display the calculation result to the user
SECOND_RESULTS=$(yad --info \
--window-icon="/usr/share/icons/stop-loss-target.png" \
--title="Stop Loss and Target Calculator Result" \
--width="400" \
--image="/usr/share/icons/Tango/scalable/emotes/face-smile.svg" \
--text="$resultPrint")
SECOND_RESULTS_RETURN_CODDE=$? # This is NOT Exit code of the program NOT the variable Information that would be found in SECOND_RESULTS
if [ $SECOND_RESULTS_RETURN_CODDE -eq "1" ]; then
    SAVE_FILE=0
fi
if [ $SAVE_FILE -eq "1" ]; then # If you want to save to file then make sure the directories exists.
    if [ ! -d $CONKY_DIR ]; then
        mkdir $CONKY_DIR
    fi
    if [ ! -d $NEAT_DIR ]; then
        mkdir $NEAT_DIR
    fi
    if [ ! -d $ADDON_DIR ]; then
        mkdir $ADDON_DIR
    fi
fi
# Save the calculation result with heading and underline to a file
if [ $SAVE_FILE -eq "1" ]; then # If you want to save to file
    {
        echo "Trade Information"
        echo "-----------------"
        echo "$result"
    } > $FILE
fi


exit 0
