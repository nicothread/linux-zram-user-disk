# Installation of zram-disk on boot

[wiki.archlinux.org - zram](https://wiki.archlinux.org/title/Zram)

## Create kernel module configuration

```
echo "zram" > /etc/modules-load.d/zram.conf
```

## Add udev rule to /etc/udev/rules.d

__Filename :__ 99-zram.rules
__Parameters for this example :__
- device : zram0
- algorithm : zstd
- size : 50M
- disk type : ext4

```
ACTION=="add", KERNEL=="zram0", ATTR{comp_algorithm}="zstd", ATTR{disksize}="50M", RUN="/usr/bin/mkfs.ext4 -U clear /dev/%k", TAG+="systemd"
```

## Mount with fstab entry

Add fstab entry for ``<mount-path>`` and ``<zram0>``.

This example for default user uid=1000 :
```
/dev/zram0 <mount-path> ext4 umask=0022,gid=1000,uid=1000
```

## Or mount with 2 services on boot for mount, on shutdown/logoff to erase data

### Mount service

__Files :__
- mount_zram_disk.service
- mount_zram_disk.sh

### Umount service

__Files :__
- erase_zram_disk.sh
- erase_zram_disk.service

