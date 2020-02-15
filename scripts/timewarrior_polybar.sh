#!/usr/bin/bash 

function help()
{
	cat <<-EOF
	Usage: $(basename "$0")
	-nl, --not_long:        Set color of msg for not long wasting/learning time.
	-l, --long:             Set color of msg for long wasting/learning time
	-tl, --too_long:        Set color of msg for too long wasting/learning time
	-wp, --wasted_period:   Set the periodicity notifications while wasitng time. Default 10 min.
	-lp, --learning_period: Set the periodicity notifications during learning. Default 25 min.
	-f, --first_level:      Set value in min for first level of learning/wasting time. Default 5 min.
	-s, --second_level:     Set value in min for second level of learning/wasting time. Default 25 min.
	-h, --help:             Display help
	EOF
}

function set_defaults()
{
  NOT_LONG='#3DD069'
  LONG='#E17E1F'
  TOO_LONG='#DF2121'
  WASTED_PERIOD=600
  LEARNING_PERIOD=1500
  FIRST_LEVEL=5
  SECOND_LEVEL=25
}

function parse_args()
{
  while (( $# )) ; do
    case "$1" in
      --not_long|-nl) shift; NOT_LONG="$1" ;shift ;;
      --long|-l) shift; LONG="$1";shift  ;;
      --too_long,-tl|-p) shift; TOO_LONG="$1"; shift ;;
      --wasted_period|-wp) shift; WASTED_PERIOD="$1"; shift ;;
      --learning_period|-lp) shift; LEARNING_PERIOD="$1"; shift ;;
      --first_level|-f) shift; FIRST_LEVEL="$1"; shift ;;
      --second_level|-s) shift; SECOND_LEVEL="$1"; shift ;;
      --help|-h) help; exit 0;;
      *)  echo "Unsupported command $1" >&2; help; exit 1 ;;
    esac
  done
}

function getActiveWindowID
{
    activeWinID=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $NF}')
    echo "$activeWinID"
}

function is_fullscreen()
{
    xprop -id "$(getActiveWindowID)" | grep "STATE_FULLSCREEN" > /dev/null >&2
}

function get_last_notify_date()
{
  [[ -e /tmp/last_notify_date ]] || date '+%F %T' > /tmp/last_notify_date
  cat /tmp/last_notify_date
}

function set_notify_period()
{
  if [[ $notify_sender_msg =~ "You are learning" ]]; then
    notify_period_in_sec=$LEARNING_PERIOD
  else
    notify_period_in_sec=$WASTED_PERIOD
  fi
}

function get_time_since_last_notify()
{
  now_in_sec=$(date -ud"$(date '+%F %T')" +%s)
  last_notify_time_in_sec=$(date -ud"$(get_last_notify_date)" +%s)
  echo $(( now_in_sec - last_notify_time_in_sec ))
}

function send_notify()
{
  if [[ (( $(get_time_since_last_notify) -ge $notify_period_in_sec )) ]]  && ! is_fullscreen; then
    notify-send --urgency=critical LearningCurve "$notify_sender_msg"
    date '+%F %T' > /tmp/last_notify_date
  fi
}

# echo_msg is reponsibility for print results on polybar
# and send notification if needed
function echo_msg()
{
  amount_of_time="$1"
  polybar_msg="$2"
  notify_sender_msg="$3"

  if [[ amount_of_time -le $FIRST_LEVEL ]]; then
    date '+%F %T' > /tmp/last_notify_date
    echo "%{F${NOT_LONG}}$polybar_msg";
  elif [[ amount_of_time -le $SECOND_LEVEL ]]; then
    echo "%{F${LONG}}$polybar_msg";
  else
    set_notify_period
    send_notify
    echo "%{F${TOO_LONG}}$2";
  fi
}

function get_time_on_learning()
{
  time_on_learning=$( task list | grep -A 2 Active | tail -n 1 | awk '{print $2}' )

  case ${time_on_learning//[0-9]/} in
    s) time_on_learning="0 min" ;;
    h) time_on_learning="$(( ${time_on_learning//[a-z]/}*60 )) min" ;;
  esac
  echo "$time_on_learning"
}

# check if end_time file exist and read it, create it if not
function read_last_task_date()
{
  if [[ -e /tmp/end_time ]]; then
    read -r last_task_date < /tmp/end_time
  else
    date '+%F %T' > /tmp/end_time
  fi
}

function set_time_vars()
{
  read_last_task_date

  now_time_sec=$(date -ud"$(date '+%F %T')" +%s)
  last_task_time_sec=$(date -ud"$last_task_date" +%s)
  waste_time_sec=$(( now_time_sec - last_task_time_sec ))

  waste_hours=$(( waste_time_sec/60/60 ))
  waste_minutes=$(( waste_time_sec/60 - waste_hours*60 ))
  wasted_time_min=$((waste_time_sec/60))
}

function save_taskid_end_time()
{
  # save taskid for other applications e.g. i3lock
  task list | grep -A 2 Active | tail -n 1 | awk '{print $1}' > /tmp/taskid;
  date '+%F %T' > /tmp/end_time; #save time when you finished doing the task
}

#checks if there is any active task and print suitable msg on polybar
function main()
{
  set_defaults
  parse_args "$@"

  if [[ $(task list | grep Active) ]]; then
    time_on_learning=$(get_time_on_learning)
    task_name=$( task list | grep -A 2 Active | tail -n 1 | awk '{print $2" "$(NF-1)}' )

    echo_msg "${time_on_learning%%[a-z]*}" \
             "  $task_name"\
             "You are learning above $time_on_learning, you deserve for rest";

    save_taskid_end_time
  else
    set_time_vars

    wasted_hours_msg="$( [[ $waste_hours != '0' ]] && echo ${waste_hours}h )"
    wasted_min_msg="${waste_minutes}min WASTED!"

    echo_msg  $wasted_time_min \
              "  $wasted_hours_msg $wasted_min_msg"\
              "What's wrong with you? $wasted_time_min min was wasted"
  fi

}

main "$@"
