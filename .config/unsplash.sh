#!/bin/bash

if [[ $(nmcli -t -f GENERAL.METERED dev show wlp4s0) = 'GENERAL.METERED:no (guessed)' ]]; then
        wget -O /var/tmp/wallpaper.jpg https://source.unsplash.com/1600x900/?water,snow && feh --bg-fill /var/tmp/wallpaper.jpg
fi
