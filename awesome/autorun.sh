#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run firefox --allow-downgrade
run flatpak run org.telegram.desktop
run telegram-desktop
run numlockx
run picom
xset b off

DEVICE_NAME="ETPS/2 Elantech Touchpad"
DEVICE_ID=$(xinput list | grep "$DEVICE_NAME" | grep -o 'id=[0-9]*' | cut -d= -f2)

if [ -n "$DEVICE_ID" ]; then
    xinput set-prop "$DEVICE_ID" "libinput Tapping Enabled" 1
fi
