#!/usr/bin/env bash
exec >/dev/null 2>&1 # daemon does not hold Handy's pipes

text="$1"

printf '%s' "$text" | xclip -selection primary
printf '%s' "$text" | xclip -selection clipboard

sleep 0.05
xdotool key Shift+Insert
