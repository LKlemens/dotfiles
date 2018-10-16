#! /bin/bash

function help() {
  cat <<-EOF
	Usage: $(basename "$0")
	--max: Set maximum capacity
	--min: Set minumum capacity
	--plugin_color, -p: Set plugin color indicator in hex
	--unplug_color, -u: Set unplug color indicator in hex
	--help, h: Display help
	EOF
}

function set_defaults()
{
    MIN=40
    MAX=80
    PLUGIN="#B11109"
    UNPLUG="#1BEE76"
    BATTERIES="/sys/class/power_supply/BAT*"
}

function match_str()
{
    [[ "$1" == "$2" ]]
}

function is_correct_number()
{
  [[ "$1" -gt 0 && "$1" -le 100 ]]
}

function parse_args()
{
    while (("$#")); do
    case $1 in
      --help|-h) help; exit 0;;
      --max) shift; is_correct_number "$1" && MAX="$1" ;shift ;;
      --min) shift; is_correct_number "$1" && MIN="$1";shift  ;;
      --plugin_color|-p) shift; PLUGIN="$1"; shift ;;
      --unplug_color|-u) shift; UNPLUG="$1"; shift ;;
      *)  echo "Unsupported command $1" >&2; help; exit 1 ;;
    esac
  done
}

function is_charging()
{
    grep Charging "${battery}"/status  > /dev/null 2>&1
}

function notify_plug()
{
    notify-send "Battery under $MIN. Please plug in the adapter  "; echo "%{F${PLUGIN}}";
}

function notify_unplug()
{
    notify-send "Battery above $MAX. Please remove the adapter "; echo "%{F${UNPLUG}}"
}

function is_max_above_min()
{
  [[ $MAX -gt $MIN ]]
}

function main()
{
  set_defaults
  parse_args "$@"
  is_max_above_min || { echo "MAX is below MIN ( $MAX < $MIN )" >&2; exit 1; }

  for battery in $BATTERIES; do
    level=$(< "$battery"/capacity)
    if [[ $level -lt $MIN ]] && ! is_charging ; then
      notify_plug
    elif [[ $level -gt $MAX ]] && is_charging; then
      notify_unplug
    else
      echo " "
    fi
  done
}


main "$@"
