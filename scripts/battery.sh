#! /bin/bash
MIN=40
MAX=80
plugin='#B11109'
unplug='#1BEE76'

for bat in /sys/class/power_supply/BAT*; do
  level=$(< "$bat"/capacity)
  if [[ $level -lt $MIN ]] ; then
    { ! grep -q Discharging "${bat}"/status && echo " "; } || { notify-send "Battery under $MIN. Please plug in the adapter  "; echo "%{F${plugin}}"; }
  elif [[ $level -gt $MAX ]] ; then
     { grep -q Discharging "${bat}"/status && echo " "; } || { notify-send "Battery above $MAX. Please remove the adapter "; echo "%{F${unplug}} "; }
  fi
done
