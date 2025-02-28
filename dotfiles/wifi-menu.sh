#!/bin/bash

# Function to set auto-connect for a network
set_autoconnect() {
    local ssid="$1"
    nmcli connection modify "$ssid" connection.autoconnect yes
    echo "Set $ssid to auto-connect."
}

# Function to connect to a WiFi network
connect_to_wifi() {
    local ssid="$1"
    local password

    # Prompt for password
    echo -n "Enter password for $ssid: "
    read -s password
    echo

    # Connect to the network
    nmcli device wifi connect "$ssid" password "$password"
}

# Get list of available WiFi networks
networks=$(nmcli --fields SSID,RATE,BARS device wifi list | tail -n +2)

# Use fzf to select a network
selected=$(echo "$networks" | fzf --reverse --header="Select WiFi Network")

# Extract SSID from selection
ssid=$(echo "$selected" | awk '{print $1}')

if [ -n "$ssid" ]; then
    connect_to_wifi "$ssid"
    
    echo -n "Do you want this network to auto-connect? (y/n): "
    read auto_choice
    if [[ $auto_choice == "y" || $auto_choice == "Y" ]]; then
        set_autoconnect "$ssid"
    fi
else
    echo "No network selected."
fi

