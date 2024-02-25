#!/bin/bash
#                _ _                              
# by Alan Cunha (2024)
# ----------------------------------------------------- 

selected=$( find $KT_OS_WALLPAPERS -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
do
  echo -en "$rfile\x00icon\x1f$HOME/wallpaper/${rfile}\n"
done | rofi -dmenu -replace)
if [ ! "$selected" ]; then
  echo "No wallpaper selected"
  exit
fi

echo $selected
