#!/bin/bash
#  
# by Alan Cunha (2024)
# ----------------------------------------------------- 

# Initialize swww
swww query || swww init

# Set the default wallpaper and the cache file location
default_wallpaper=$KT_OS_DEFAULT_WALLPAPER
cache_file="$KT_OS_CACHE/wallpaper"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
  touch $cache_file
  echo $default_wallpaper > "$cache_file"
fi

  # Get current wallpaper path
current_wallpaper=$(cat "$cache_file")

# Set the cached wallpaper
swww img $current_wallpaper \
  --transition-bezier .43,1.19,1,.4 \
  --transition-fps=60 \
  --transition-type=wipe \
  --transition-duration=0.7 \
  --transition-pos "$( hyprctl cursorpos )"
