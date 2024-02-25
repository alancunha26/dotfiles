#!/bin/bash
#  
# by Alan Cunha (2024)
# ----------------------------------------------------- 

# Set the default theme and the cache file location
default_theme=$KT_OS_DEFAULT_THEME
theme_cache_file="$KT_OS_CACHE/theme"

# Create theme cache file if not exists
if [ ! -f $theme_cache_file ] ;then
    touch $theme_cache_file
    echo $default_theme > "$theme_cache_file"
fi

# Get theme path
current_theme=$(cat "$theme_cache_file")

# Set the current theme for rofi
rofi_cache_file="$KT_OS_CACHE/rofi-theme.rasi"
rofi_theme_file=$HOME/.config/rofi/themes/$current_theme.rasi

# Create rofi theme cache file if not exists
if [ ! -f $rofi_cache_file ] ;then
  cp $rofi_theme_file $rofi_cache_file
fi
