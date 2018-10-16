#!/usr/bin/bash
ok='#3DD069'
long='#E17E1F'
too_long='#DF2121'
wasted_period=600
learning_period=1500


# is_fullscreen checks if current window is in fullscreen mode
# if it is then notifies do not show up
is_fullscreen()
{
  active_window_resolution=$(xwininfo -id "$(xdotool getactivewindow)" -stats | grep -E '(Width|Height)' | awk '{print $NF}' | xargs | sed 's/ //g')
  screen_resolution=$(xrandr | grep '*' | tr 'x' ' ')
  screen_resolution=${screen_resolution% *}
  screen_resolution=${screen_resolution// /}

  [[ "$active_window_resolution" = "$screen_resolution" ]]
}

# echo_msg is reponsibility for print results on polybar
# and send notification if time on task exceeded 25 min
# funciton takes three aguments:
#   1st stores learning/wasting time
#   2nd msg for polybar
#   3rd msg for notify-sender
echo_msg()
{
  if [[ $1 -le 5 ]]; then
    date '+%F %T' > /tmp/time_for_notify_sender
    echo "%{F${ok}}$2";
  elif [[ $1 -le 25 ]]; then
    echo "%{F${long}}$2";
  else

    diff_time_for_notify_sec=$(( $(date -ud"$(date '+%F %T')" +%s) \
                             - $(date -ud"$(cat /tmp/time_for_notify_sender 2>/dev/null || date '+%F %T' | tee /tmp/time_for_notify_sender)" +%s) ))

    notify_period_in_sec=$wasted_period
    if [[ $3 =~ "you deserve for rest" ]]; then
      notify_period_in_sec=$learning_period
    fi

    [[ (($diff_time_for_notify_sec -ge $notify_period_in_sec )) ]]  && ! is_fullscreen \
    && notify-send --urgency=critical LearningCurve "$3" \
    && date '+%F %T' > /tmp/time_for_notify_sender

    echo "%{F${too_long}}$2";
  fi
}

#checks if there is any active task and print suitable msg on polybar
main()
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

main
