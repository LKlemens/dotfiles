#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

#if [ -f $sysresources ]; then
#
#
#
#
#
#
#
#    xrdb -merge $sysresources
#
#fi
#
#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi
#
#if [ -f "$userresources" ]; then
#
#
#
#
#
#
#
#    xrdb -merge "$userresources"
#
#fi
#
#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#fi
#
## start some nice programs
#
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
# for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#  [ -x "$f" ] && . "$f"
# done
# unset f
#fi
#
##twm &
##xclock -geometry 50x50-1+1 &
##xterm -geometry 80x50+494+51 &
##xterm -geometry 80x20+494-0 &
##exec xterm -geometry 80x66+0+0 -name login
firefox &
feh --bg-scale /home/klemens/Documents/arch.jpg &
feh -F /home/klemens/Documents/arch.jpg &
systemctl --user import-environment DISPLAY&
clipmenud &
setxkbmap pl
setxkbmap -option "caps:backspace"
setxkbmap -option "shift:both_capslock"
xmodmap -e "clear Lock"
exec dunst -no-startup-id&
# termite --class=Upgrade --hold -e "bash -c \"rm -rf ~/.pomo/pomo.sock; ~/.config/scripts/pomo start -t my-project \"write some codes\"\""&
# xscreensaver&
# lightsOn.sh 500&
termite --class=Upgrade --hold -e " bash -c \"tmux attach || tmux\""&
pgrep caffeine &> /dev/null || caffeine &> /dev/null &
#signal-desktop&
# pgrep xautolock &> /dev/null || xautolock -locker 'better2 -l dim'&
# pgrep xautolock &> /dev/null || xautolock -locker 'i3lock -i ~/.cache/i3lock/current/l_dim.png -u'&
xidlehook \
  --time 5 \
  --timer 'task stop $(cat /tmp/taskid); i3lock -i /home/klemens/Documents/archwall.png -u' \
  --notify 3 \
  --notifier  'xrandr --output "$(xrandr | grep primary | cut -d " " -f 1)" --brightness .1' \
  --not-when-fullscreen \
  --not-when-audio &
eval "$(ssh-agent -s)"
#spotify &
pgrep redshift &> /dev/null || redshift &> /dev/null &
/usr/bin/syncthing -no-browser -no-restart -logflags=0&
exec i3

