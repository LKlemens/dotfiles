#! /bin/bash

function help()
{
  cat <<-EOF
	Usage: $(basename "$0")
	--max:                 Set maximum capacity. Default 80%.
	--min:                 Set minumum capacity. Default 40%.
	-n, --notify_treshold: Set treshold for notify about plugin/unplug. Default 5%.
	--plugin_color, -p:    Set plugin color indicator in hex. Default #B11109.
	--unplug_color, -u:    Set unplug color indicator in hex. Default #1BEE76.
	--help, h:             Display help
	EOF
}

function set_defaults()
{
    MIN=40
    MAX=80
    NOTIFY_TRESHOLD=5
    PLUGIN="#B11109"
    UNPLUG="#1BEE76"
    BATTERIES="/sys/class/power_supply/BAT*"
}

function is_correct_number()
{
  [[ "$1" -gt 0 && "$1" -le 100 ]]
}

function parse_args()
{
  while (("$#")); do
    case $1 in
      -h|--help) help; exit 0;;
      --max) shift; is_correct_number "$1" && MAX="$1" ;shift ;;
      --min) shift; is_correct_number "$1" && MIN="$1";shift ;;
      -n|--notify_treshold) shift; is_correct_number "$1" && NOTIFY_TRESHOLD="$1";shift  ;;
      -p|--plugin_color) shift; PLUGIN="$1"; shift ;;
      -u|--unplug_color) shift; UNPLUG="$1"; shift ;;
      *)  echo "Unsupported command $1" >&2; help; exit 1 ;;
    esac
  done
}

function match_str()
{
    [[ "$1" == "$2" ]]
}

function is_charging()
{
    grep Charging "${battery}"/status  > /dev/null 2>&1
}

function notify_unplug()
{
    notify-send "Battery level $LEVEL. Please remove the adapter "; echo "%{F${UNPLUG}}"
}

function notify_plug()
{
    notify-send "Battery level $LEVEL. Please plug in the adapter  "; echo "%{F${PLUGIN}}";
}

function is_max_above_min()
{
  [[ $MAX -gt $MIN ]]
}

function is_integer()
{
  [[ $1 =~ ^-?[0-9]+$ ]]
}

function battery_level_diff()
{
  [[ -e /tmp/battery_level ]] || save_battery_level
  last_notify_battery_level="$(< /tmp/battery_level)"
  echo $(( last_notify_battery_level - LEVEL ))
}

function abs()
{
  is_integer "$1" && echo ${1#-} || { echo "$1 is not integer"; exit 1; }
}

function save_battery_level()
{
  echo "$LEVEL" > /tmp/battery_level
}

function is_treshold_reached()
{
  diff="$(abs "$(battery_level_diff)")"
  [[ $diff -ge $NOTIFY_TRESHOLD ]]
}

function main()
{
  set_defaults
  parse_args "$@"
  is_max_above_min || { echo "MAX is below MIN ( $MAX < $MIN )" >&2; exit 1; }

  for battery in $BATTERIES; do
    LEVEL=$(< "$battery"/capacity)
    if [[ $LEVEL -lt $MIN ]] && ! is_charging ; then
      is_treshold_reached && notify_plug && save_battery_level
    elif [[ $LEVEL -gt $MAX ]] && is_charging; then
      is_treshold_reached && notify_unplug && save_battery_level
    else
      echo " "
    fi

  done
}

main "$@"
