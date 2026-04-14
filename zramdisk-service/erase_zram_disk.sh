#!/bin/bash -u
# Only proceed if the drive is present.
if [[ ! -b "/dev/zram0" ]]; then
  echo "zram not found"
  exit 0
fi

# Erase data from zram
umount /dev/zram0
shred /dev/zram0
mkfs.ext4 /dev/zram0 
echo "zram0 erased"
