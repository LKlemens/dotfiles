#!/bin/env bash

# scrot -s -d 1 -e 'mv $f ~/screens/'
region='region'
entire='entire desktop'
active='active window'
DMENU='rofi -dmenu -i'

CMD=$(
	echo -e \
		"$region\\n$entire\\n$active" | rofi -dmenu \
		-p "screenshot: "
)
input="$(xsel -o > /dev/null | $DMENU -p 'name')"
case $CMD in
$region)
  scrot -s && mv ~/*.png ~/screens/$input.png
	;;
$entire)
  scrot -d 1 && mv ~/*.png ~/screens/$input.png
	;;
$active)
  scrot -d 1 -u && mv ~/*.png ~/screens/$input.png
  ;;
esac
