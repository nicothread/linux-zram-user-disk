#!/bin/bash

app_id=$( swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused==true) | .app_id'  )
if [[ $app_id != "org.keepassxc.KeePassXC" ]]; then
      
      if [ -z /srv/.zramdisk/$USER/.clipboard ]; then
        touch /srv/.zramdisk/$USER/.clipboard
      fi
      chmod 660 /srv/.zramdisk/$USER/.clipboard
      
      echo -e "\n" >> /srv/.zramdisk/$USER/.clipboard
      cat /dev/stdin >> /srv/.zramdisk/$USER/.clipboard

      awk -i inplace '!seen[$0]++' /srv/.zramdisk/$USER/.clipboard
fi
