#!/bin/bash
#
# Source: https://github.com/Petingoso/dotfiles/blob/master/dot_local/bin/executable_theme_changer_WL
# by Alan Cunha (2024)
# ----------------------------------------------------- 


# Directory
hypr_dir="$HOME/.config/hypr"
rofi_dir="$HOME/.config/rofi"
kitty_dir="$HOME/.config/kitty"
waybar_dir="$HOME/.config/waybar"
gtk3_settings="$HOME/.config/gtk-3.0/"
nvim_settings="$HOME/.config/nvim/lua/custom/chadrc.lua"

# Functions
change_theme()
{
  echo $1 > $KT_OS_CACHE/theme
	cp ${rofi_dir}/themes/$1.rasi $KT_OS_CACHE/rofi-theme.rasi
	# cp ${hypr_dir}/$1.conf ${hypr_dir}/color.thmswitch
	# cp ${kitty_dir}/colorscheme/$1.conf ${kitty_dir}/color.thmswitch
	# cp ${waybar_dir}/all.css ${waybar_dir}/style.css
  sed -i "s/\(M.ui.theme = \)\"[^\"]*\"/\1\"$1\"/" $nvim_settings
	# if [[ "$1" == "cozy-night" ]]; then
	# 	sed -i 's/\(.*colorscheme\s*\)[^"]*/\1'"tokyonight-night"'/' $nvim_settings
	# elif [[ "$1" == "catppuccin_macchiato" ]]; then
	# 	sed -i 's/\(.*colorscheme\s*\)[^"]*/\1'"catppuccin"'/' $nvim_settings
	# elif [[ "$1" == "everforest" ]]; then
	# 	cp ${waybar_dir}/everforest.css ${waybar_dir}/style.css
	# fi

	hyprctl reload # restart hyprland
	kill -USR1 $(pidof kitty) #restart kitty
}

# Themes
theme1=" Nord"
theme2=" Everforest"
theme3=" Solarized"
theme4=" Catppuccin"
theme5=" Rosé Pine"
theme6=" Gruvbox"
theme7=" Dracula"
theme8=" Tokyo Night"
theme9=" Wallpaper (pywall)"

# Variable to pass to dmenu or rofi
option="$theme1\n$theme2\n$theme3\n$theme4\n$theme5\n$theme6\n$theme7\n$theme8\n$theme9"
prompt="rofi -dmenu -theme $rofi_dir/themes.rasi"
select="$(echo -e "$option" | $prompt -p "Choose a theme: " )"
case $select in
	$theme1)
		change_theme nord
		# change_gtk_theme Nordic
		;;
	$theme2)
		change_theme everforest
		# change_gtk_theme everforest
		;;
	$theme3)
		change_theme solarized
		# change_gtk_theme NumixSolarizedDarkRed
		;;
	$theme4)
		change_theme catppuccin
		# change_gtk_theme Catppuccin-Macchiato-Standard-Red-Dark
		;;
	$theme5)
		change_theme rose-pine
		# change_gtk_theme RosePine-Main-B
		;;
	$theme6)
		change_theme gruvbox
		# change_gtk_theme Gruvbox-Material-Dark
		;;
	$theme7)
		change_theme dracula
		# change_gtk_theme RosePine-Main-B
		;;
	$theme8)
		change_theme tokyo-night
		# change_gtk_theme TokyoNight
		;;
esac
