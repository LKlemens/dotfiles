#! /bin/bash -x

function help() {
  cat <<-EOF
	Usage: $(basename "$0")
	--max: Set maximum capacity. Default 80.
	--min: Set minumum capacity. Default 40.
	--plugin_color, -p: Set plugin color indicator in hex. Default #B11109.
	--unplug_color, -u: Set unplug color indicator in hex. Default #1BEE76.
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

function match_str()
{
    [[ "$1" == "$2" ]]
}

function is_charging()
{
    grep Charging "${battery}"/status  > /dev/null 2>&1
}

function getActiveWindowID
{
    activeWinID=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $NF}')
    echo "$activeWinID"
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

function is_battery_diff_5_percentage_since_last_notify()
{
  [[ -e /tmp/battery_level ]] || echo "$LEVEL" > /tmp/battery_level
  last_notify_battery_level="$(< /tmp/battery_level)"
  diff_battery_level=$(( last_notify_battery_level - LEVEL ))
  abs_diff_battery_level=${diff_battery_level#-}
  [[ abs_diff_battery_level -ge 5 ]]
}

function main()
{
  set_defaults
  parse_args "$@"
  is_max_above_min || { echo "MAX is below MIN ( $MAX < $MIN )" >&2; exit 1; }

  for battery in $BATTERIES; do
    LEVEL=$(< "$battery"/capacity)
    if [[ $LEVEL -lt $MIN ]] && ! is_charging ; then
      is_battery_diff_5_percentage_since_last_notify && notify_plug && echo "$LEVEL" > /tmp/battery_level
    elif [[ $LEVEL -gt $MAX ]] && is_charging; then
      is_battery_diff_5_percentage_since_last_notify && notify_unplug && echo "$LEVEL" > /tmp/battery_level
    else
      echo " "
    fi
  done
}


main "$@"
