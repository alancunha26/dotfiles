#!/bin/bash
#                _ _                              
# by Alan Cunha (2024)
# ----------------------------------------------------- 

# CMDs
lastlogin="`last $USER | head -n1 | tr -s ' ' | cut -d' ' -f5,6,7`"
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
hibernate=''
shutdown=''
reboot=''
lock=''
suspend=''
logout='󰍃'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p " $USER@$HOST" \
		-mesg " Uptime: $uptime" \
		-theme ~/.config/rofi/power.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
  if [[ $1 == '--shutdown' ]]; then
    shutdown
  elif [[ $1 == '--reboot' ]]; then
    reboot
  elif [[ $1 == '--hibernate' ]]; then
    hibernate
  elif [[ $1 == '--suspend' ]]; then
    suspend
  elif [[ $1 == '--logout' ]]; then
    hyprctl dispatch exit
  elif [[ $1 == '--lock' ]]; then
    swaylock -l
  fi
}

# Actihyprctl dispatch exitons
chosen="$(run_rofi)"
case ${chosen} in
  $shutdown)
  run_cmd --shutdown
    ;;
  $reboot)
  run_cmd --reboot
    ;;
  $hibernate)
  run_cmd --hibernate
    ;;
  $lock)
  run_cmd --lock
    ;;
  $suspend)
  run_cmd --suspend
    ;;
  $logout)
  run_cmd --logout
    ;;
esac
