#!/bin/sh

bat=/sys/class/power_supply/BAT0

CRIT=15
LOW=30

FILE=~/.config/waybar/scripts/notified
FILE2=~/.config/waybar/scripts/notified2

stat=$(cat $bat/status)
perc=$(cat $bat/capacity)

if [[ $perc -le $CRIT ]] && [[ $stat == "Discharging" ]]; then
  if [[ ! -f "$FILE" ]]; then
    notify-send --urgency=critical --icon=dialog-warning "Battery Critical" "Current charge: $perc%"
    paplay ~/.config/waybar/scripts/windows_10_low_battery.mp3
    brightnessctl -s set 20
    touch $FILE
  fi
elif [[ -f "$FILE" ]]; then
  rm $FILE
fi


if [[ $perc -le $LOW ]] && [[ $stat == "Discharging" ]]; then
  if [[ ! -f "$FILE2" ]]; then
    notify-send --urgency=normal --icon=dialog-warning "Battery Low" "Current charge: $perc%"
    paplay ~/.config/waybar/scripts/windows_10_low_battery.mp3
    touch $FILE2
  fi
elif [[ -f "$FILE2" ]]; then
  rm $FILE2
fi

