#!/bin/env bash

FACEBOOK_MESSENGER='facebook'
# SLACK='slack'
MAIL='gmail'
SPOTIFY='spotify'
POMO='pomo'

CMD=$(
	echo -e \
		"$FACEBOOK_MESSENGER\\n$MAIL\\n$SPOTIFY\\n$POMO" | rofi -dmenu \
		-p "messengers: "
)
case $CMD in
$FACEBOOK_MESSENGER)
	exec i3-msg -t command "[con_mark=\"messenger-client\"] scratchpad show"
	;;
$SLACK)
	exec i3-msg -t command "[con_mark=\"slack-client\"] scratchpad show"
	;;
$SPOTIFY)
  exec i3-msg -t command "[con_mark=\"music\"] scratchpad show"
  ;;
$POMO)
  exec i3-msg -t command "[con_mark=\"pomo\"] scratchpad show"
  ;;
$MAIL)
  exec i3-msg -t command "[con_mark=\"mail\"] scratchpad show"
  ;;
esac
