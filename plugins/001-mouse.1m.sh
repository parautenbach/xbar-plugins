#!/bin/bash
# <xbar.title>Mouse battery</xbar.title>
# <xbar.version>1.0</xbar.version>
# <xbar.author>Pieter Rautenbach</xbar.author>
# <xbar.author.github>parautenbach</xbar.author.github>
# <xbar.desc>Show battery percentage for Bluetooth Mouse. Adapted from Alexandre Espinosa Menor's version.</xbar.desc>
# <xbar.image>https://github.com/parautenbach/xbar-plugins/blob/main/example.png</xbar.image>

PERCENTAGE=$(ioreg -n BNBMouseDevice | fgrep BatteryPercent | fgrep -v \{ | sed 's/[^[:digit:]]//g')
# Detect and adjust for M1 Mac
if [[ $(uname -m) == 'arm64' ]]; then
  PERCENTAGE=$(ioreg -c AppleDeviceManagementHIDEventService -r -l | grep -i mouse -A 20  | grep BatteryPercent | cut -d = -f2 | cut -d ' ' -f2)
fi

ICON="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"

if [ "$PERCENTAGE" ]; then
  OUTPUT="$PERCENTAGE% | templateImage=$ICON"
  if [ "$PERCENTAGE" -lt 15 ]; then
    echo "$OUTPUT | color=red"
  else
    echo "$OUTPUT"
  fi
fi

