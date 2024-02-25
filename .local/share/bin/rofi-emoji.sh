#! /bin/bash
url="https://www.unicode.org/Public/emoji/latest/emoji-test.txt"
rofi_dir = ~/.config/rofi
file="$KT_OS_CACHE/emojis"

if [ ! -f "$file" ]; then
    curl -L "$url" -o "$file"
fi

readarray -t data < <(grep "^[^#].*fully-qualified" "$file" | cut -d '#' -f2 | cut -d ' ' -f 2,4-10)
selected=$(printf '%s\n' "${data[@]}" | rofi -dmenu -p Emoji -format i -theme $rofi_dir/emoji.rasi )
emoji=$(printf "${data[$selected]}" | cut -d ' ' -f 1)
wl-copy $emoji
