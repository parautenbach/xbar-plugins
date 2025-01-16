#!/bin/bash
# <xbar.title>Airpods battery</xbar.title>
# <xbar.version>1.0</xbar.version>
# <xbar.author>Pieter Rautenbach</xbar.author>
# <xbar.author.github>parautenbach</xbar.author.github>
# <xbar.desc>Show battery percentage for Airpods.</xbar.desc>
# <xbar.image>https://github.com/parautenbach/xbar-plugins/blob/main/example.png</xbar.image>

# Log file for debugging
log_file="/tmp/parse_bluetooth.log"

# Device name to filter
device_name="Aura"

# Log the start of the script
echo "Script started at $(date)" > "$log_file"

# Get Bluetooth information in JSON format
bluetooth_info=$(/usr/sbin/system_profiler -json SPBluetoothDataType 2>> "$log_file")

# Log the Bluetooth information
echo "Bluetooth info: $bluetooth_info" >> "$log_file"

# Extract device information for the specified device using jq
device_info=$(echo "$bluetooth_info" | /opt/homebrew/bin/jq -r --arg device_name "$device_name" '
  .SPBluetoothDataType[].device_connected[] | select(has($device_name)) | .[$device_name]
' 2>> "$log_file")

# Log the device information
echo "Device info: $device_info" >> "$log_file"

# Check if device information is found
if [ -z "$device_info" ]; then
  echo "No device info found" >> "$log_file"
  exit 0
fi

# Extract Left and Right Battery Levels
left_battery=$(echo "$device_info" | /opt/homebrew/bin/jq -r '.device_batteryLevelLeft' | tr -d '%' 2>> "$log_file")
right_battery=$(echo "$device_info" | /opt/homebrew/bin/jq -r '.device_batteryLevelRight' | tr -d '%' 2>> "$log_file")

# Log the battery levels
echo "Left Battery: $left_battery" >> "$log_file"
echo "Right Battery: $right_battery" >> "$log_file"

# Calculate the average
average_battery=$(( (left_battery + right_battery) / 2 ))

# Log the average battery level
echo "Average Battery: $average_battery" >> "$log_file"

icon="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"

battery_text="$left_battery% / $right_battery% | templateImage=$icon"

if [ "$average_battery" -lt 15 ]; then
  echo "$battery_text color=red"
else
  echo "$battery_text"
fi
