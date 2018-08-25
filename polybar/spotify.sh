#!/bin/sh


main() {
  if ! pgrep -x spotify >/dev/null; then
    echo ""; exit
  fi

  cmd="org.freedesktop.DBus.Properties.Get"
  domain="org.mpris.MediaPlayer2"
  path="/org/mpris/MediaPlayer2"

  meta=$(dbus-send --print-reply --dest=${domain}.spotify \
    /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:${domain}.Player string:Metadata)

  artist=$(echo "$meta" | sed -nr '/xesam:artist"/,+2s/^ +string "(.*)"$/\1/p' | tail -1)
  album=$(echo "$meta" | sed -nr '/xesam:album"/,+2s/^ +variant +string "(.*)"$/\1/p' | tail -1)
  title=$(echo "$meta" | sed -nr '/xesam:title"/,+2s/^ +variant +string "(.*)"$/\1/p' | tail -1)

  var=$(echo "${*:-%artist% - %title%}" | sed "s/%artist%/$artist/g;s/%title%/$title/g;s/%album%/$album/g"i | sed 's/&/\\&/g')
  # if [ ${#var} -gt 22 ]
  # then
  #   for ((c=0; c<=${#var}; ++c));
  #   do
  #     sleep 0.3
  #     if [[ $[ $c + 10 ] > 22 ]];
  #     then
  #       echo "${var:$c:$c + 10}       ${var:0:$c - 13}"
  #     else
  #       echo "${var:$c:22}"
  #     fi
  #   done
  # else
  if [[ ${var} == *xesam* ]]
  then
    echo ""
  else
    echo "${var}"
  fi
  # fi



}


main "$@"
