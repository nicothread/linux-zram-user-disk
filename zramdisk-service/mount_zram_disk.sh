#!/bin/bash -u
# Only proceed if the drive is present.
if [[ ! -b "/dev/zram0" ]]; then
  echo "zram not found"
  exit 0
fi

# Monunt zram
if [[ ! "$(findmnt "/dev/zram0" | tail -1)" == "" ]]; then
  echo "zram already mounted"
else
  mkdir -p "/srv/.zramdisk"
  mount "/dev/zram0" "/srv/.zramdisk/"
  echo "zram mounted"
fi


# Examples :
#  lusrs=`who -q | sort -r | tail -1 | tr " " "\n" | uniq`
#  uids=`cat /etc/login.defs | grep -E '^UID_MIN|^UID_MAX' | sed -r 's/[\t ]*//g;s/[A-Z_]*/&=/'`
#  uids=`cat /etc/login.defs | grep -E '^UID_MIN|^UID_MAX' | sed -r 's/[A-Z_]*[\t ]*//g'`
#  getent passwd {[aruids[0]]..[aruids[1]]}

  uids=`cat /etc/login.defs | grep -E '^UID_MIN|^UID_MAX' | sed -r 's/[A-Z_]*[\t ]*//g;' | tr '\n' ' '`
  read -a aruids <<< $uids;

  for iusr in $(seq ${aruids[0]} ${aruids[1]});  do
    username=`getent passwd $iusr | sed -r 's/(^[a-zA-Z0-9\._\-]*).*/\1/ig'`
    if [ "$username" == "" ]; then
      break
    else
      echo "add space for user : $username"
      mkdir -p "/srv/.zramdisk/$username"
      chown $iusr:$iusr "/srv/.zramdisk/$username"
      chmod 0760 "/srv/.zramdisk/$username"
    fi
  done
  echo "zramdisk configured"

