#!/bin/bash
pkill wl-paste

wl-paste -t text -pw "${HOME}/.config/sway/run_filteredclip.sh" 2>&1 & > /dev/null
