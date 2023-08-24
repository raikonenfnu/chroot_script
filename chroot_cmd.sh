#!/bin/bash

# Usage: /path/to/enter_chroot_script /path/to/chroot_dir

chroot_dir=$1

if [ ! -d "$chroot_dir" ]; then
    	echo "Chroot directory '$chroot_dir' could not be located"
    	exit 1
fi

bind_mounts=(
    	"/sys"
    	"/proc"
    	"/data"
    	"/dev"
    	"/dev/pts"
)

for bind_mount in "${bind_mounts[@]}"; do
    	mount -o bind,rw "$bind_mount" "$chroot_dir$bind_mount"
    	echo "Mounted $bind_mount to $chroot_dir$bind_mount"
done

chroot "$chroot_dir" /bin/bash

for ((i=${#bind_mounts[@]}-1; i>=0; i--)); do
    	umount -l "$chroot_dir${bind_mounts[i]}"
    	echo "Unmounted $chroot_dir${bind_mounts[i]}"
done

echo "Successfully left chroot $chroot_dir"
