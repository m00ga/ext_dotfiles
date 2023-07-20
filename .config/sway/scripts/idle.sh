#!/bin/zsh

prefix="$HOME/.config/sway/scripts"
remove="$prefix/remove.sh"
lock="$prefix/lock.sh"
idle="$prefix/idle.sh"
check="$prefix/check.sh"

if [[ $1 == "--button" ]]; then
    "$remove"
    sleep 1
    swayidle -w \
	timeout 1 "$lock; sleep 1; $check &" \
        unlock "$remove && $idle" \
	timeout 10 'systemctl suspend'
elif [[ $1 == "--second-stage" ]]; then
    swayidle -w timeout 150 "systemctl suspend"
else
    "$remove"
    sleep 1
    swayidle -w \
        timeout 10 "brightnessctl -d kbd_backlight -s set 0" \
        resume "brightnessctl -d kbd_backlight -r" \
        timeout 300 "loginctl lock-session; sleep 1; $check &" \
        lock "$lock; ($idle --second-stage &)" \
        unlock "pkill -f swayidle -n"
fi
