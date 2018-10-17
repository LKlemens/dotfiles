#!/usr/bin/bash

function help()
{
	cat <<-EOF
	Usage: $(basename "$0")
	--not_long, -nl: Set color of msg for not long wasting/learning time
	--long, -l: Set color of msg for long wasting/learning time
	--too_long, -tl, -p: Set color of msg for too long wasting/learning time
	--wasted_period, -wp, -u: Set the periodicity notifications while wasitng time
  --learning_period, -lp, -u: Set the periodicity notifications during learning
	--help, h: Display help
	EOF
}

function set_defaults()
{
  NOT_LONG='#3DD069'
  LONG='#E17E1F'
  TOO_LONG='#DF2121'
  WASTED_PERIOD=600
  LEARNING_PERIOD=1500
}

function parse_args()
{
    while (("$#")); do
    case $1 in
      --help|-h) help; exit 0;;
      --not_long|-nl) shift; NOT_LONG="$1" ;shift ;;
      --long|-l) shift; LONG="$1";shift  ;;
      --too_long,-tl|-p) shift; TOO_LONG="$1"; shift ;;
      --wasted_period|-wp) shift; WASTED_PERIOD="$1"; shift ;;
      --learning_period|-lp) shift; LEARNING_PERIOD="$1"; shift ;;
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

# echo_msg is reponsibility for print results on polybar
# and send notification if time on task exceeded 25 min
function echo_msg()
{
  amount_of_time="$1"
  polybar_msg="$2"
  notify_sender_msg="$3"

  if [[ amount_of_time -le 5 ]]; then
    date '+%F %T' > /tmp/time_for_notify_sender
    echo "%{F${NOT_LONG}}$polybar_msg";
  elif [[ amount_of_time -le 25 ]]; then
    echo "%{F${LONG}}$polybar_msg";
  else

    diff_time_for_notify_sec=$(( $(date -ud"$(date '+%F %T')" +%s) \
                             - $(date -ud"$(cat /tmp/time_for_notify_sender 2>/dev/null || date '+%F %T' | tee /tmp/time_for_notify_sender)" +%s) ))

    notify_period_in_sec=$WASTED_PERIOD
    if [[ $notify_sender_msg =~ "you deserve for rest" ]]; then
      notify_period_in_sec=$LEARNING_PERIOD
    fi

    [[ (($diff_time_for_notify_sec -ge $notify_period_in_sec )) ]]  && ! is_fullscreen \
    && notify-send --urgency=critical LearningCurve "$notify_sender_msg" \
    && date '+%F %T' > /tmp/time_for_notify_sender

    echo "%{F${TOO_LONG}}$2";
  fi
}

#checks if there is any active task and print suitable msg on polybar
function main()
{
  if [[ $(task list | grep Active) ]]; then
    time_on_learning=$( task list | grep -A 2 Active | tail -n 1 | awk '{print $2}' )

    case ${time_on_learning//[0-9]/} in
      s) time_on_learning="0 min" ;;
      h) time_on_learning="$(( ${time_on_learning//[a-z]/}*60 )) min" ;;
    esac

    echo_msg "${time_on_learning%%[a-z]*}" \
             " $( task list | grep -A 2 Active | tail -n 1 | awk '{print $2" "$5}' )"\
             "You are learning above $time_on_learning, you deserve for rest";

    # save taskid for other applications e.g. i3lock
    task list | grep -A 2 Active | tail -n 1 | awk '{print $1}' > /tmp/taskid;
    date '+%F %T' > /tmp/timewvar; #save time when you finished doing the task

  else

    [[ -e /tmp/timewvar ]] && read -r last_task_date < /tmp/timewvar \
    || date '+%F %T' > /tmp/timewvar # check if timewvar file exist and read it, create it if not

    waste_time_sec=$(( $(date -ud"$(date '+%F %T')" +%s) \
                        - $(date -ud"$last_task_date" +%s) ))
    waste_hours=$(( waste_time_sec/60/60 ))
    waste_minutes=$(( waste_time_sec/60 - waste_hours*60 ))
    wasted_time_min=$((waste_time_sec/60))

    echo_msg  $wasted_time_min \
              " $( [[ $waste_hours != '0' ]] && echo ${waste_hours}h ) ${waste_minutes}min WASTED!"\
              "What wrong with you? $wasted_time_min min was wasted"
  fi

}
set_defaults
main
