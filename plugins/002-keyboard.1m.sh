#!/bin/bash
# <xbar.title>Mouse battery</xbar.title>
# <xbar.version>1.0</xbar.version>
# <xbar.author>Alexandre Espinosa Menor</xbar.author>
# <xbar.author.github>alexandregz</xbar.author.github>
# <xbar.desc>Show battery percentage for Bluetooth Mouse</xbar.desc>
# <xbar.image>http://i.imgur.com/IqjZMJg.png</xbar.image>

# works fine with Magic Mouse

PERCENTAGE=$(ioreg -n BNBMouseDevice | fgrep BatteryPercent | fgrep -v \{ | sed 's/[^[:digit:]]//g')
# Detect and adjust for M1 Mac
if [[ $(uname -m) == 'arm64' ]]; then
  PERCENTAGE=$(ioreg -c AppleDeviceManagementHIDEventService -r -l | grep -i keyboard -A 20  | grep BatteryPercent | cut -d = -f2 | cut -d ' ' -f2)
fi

ICON="iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAYAAAAehFoBAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAhGVYSWZNTQAqAAAACAAFARIAAwAAAAEAAQAAARoABQAAAAEAAABKARsABQAAAAEAAABSASgAAwAAAAEAAgAAh2kABAAAAAEAAABaAAAAAAAAAJAAAAABAAAAkAAAAAEAA6ABAAMAAAABAAEAAKACAAQAAAABAAAALKADAAQAAAABAAAALAAAAADuVgY2AAAACXBIWXMAABYlAAAWJQFJUiTwAAABWWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgoZXuEHAAADNklEQVRYCe2Xu4oVQRCG1xtqYKCCCLqwiyAGiokYn1gM3NQX0NTLQ/gAgmabmYogxj6AmBhotBgoiOAaGHi//N9M/4eai2PPnOPZFafgP11dXV31d3XN7OzS0ihjBcYKjBX4LyqwW6fctYUnJTccsmRnltdinBpcdtTyMv8prAlXhKNC3Uemvyo/FP2tcFe4L5iT1Kr4Cm7KDOntgBuJorlNq0fPfBeWhQ0Bh89phHi9ym02uRWHnIfvN8XaKzCuCq+EgqN7xOM5LUDWG9z8EOSqADo+7LGNkTn2WX3JabLEOy8gBUcMUfanSb1KdT8T3BM3S8c+i28MZw7mVKzVg8cNUX+kybtkOKjxovBSeCzsEz4JE2FFeCi8F5A+voflf6HYVf3hxhriSl3WCg60BNVCB/SR5ZgUbOs2pJE5dtYtfXzJwX5AbjigwwkpOBZ9Uc4bv74SFg6FVSqBUFnkQDlM517HbD3HN+aIuVP4cugizOksm1Y0ujVoA+RDORRtger1qOf4xhwxdwpfDl09HE95OxChL5GJsC7EHta0eOHHHsY2Ef7k69vAP+Zm3pC2HuaUIPaybbyzrcexzd5mY0+bPebq3cMERTjtJeFEAm8IWom3wXHhbBqZY2d9iC85XFnnlqkquS3xQts2qluLV9dr2QDiNngufYivb5lYJo5eESryT0lXheNBTofJqaTzkKwKvI54wv3QnJHuavXxjTkUolucIP7hiA/TVuitD11uhduOyxPNkz5E+MAZ1I5DCUOWhIOSphM6RprmDUMIU1Uq9Ey4J/A1RXKe7LbXkZ941jjgR4HWo9cdS2qezEL4iVLcykvT8Dopy8IIu2L8SUYYc3uZm+G7wnsdS6Y8qVe4TwDaAOFfqbZWKBZrPzz5iPeWsx6/dcL0F9JFwHv42H4qMO/y1/JUKAikV5LFsdK0MjimOVUWuSqEb4OvAs5cHcGZR2D7IuAzC4jxu/jkJjbrywJijuVMvz7tNemzEJnn3uuJnbk1PjK4MhKuCVeFI8Is71pt7y3kfyPcER4I5iS1XRZNsJ1Fac3mwhU0eqYr8pzXyD1tgznHHsONFRgrMFZgO1XgFwb5UKVNCubYAAAAAElFTkSuQmCC"

if [ "$PERCENTAGE" ]; then
  OUTPUT="$PERCENTAGE% | templateImage=$ICON"
  if [ "$PERCENTAGE" -lt 15 ]; then
    echo "$OUTPUT | color=red"
  else
    echo "$OUTPUT"
  fi
fi

