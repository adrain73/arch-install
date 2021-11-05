#!/bin/bash

### Check for internet connection
echo "Checking for internet connection . . ."
if nc -zw1 8.8.8.8 443; then
    echo -e "Connected. Proceeding.\n"
else
    echo "No internet. Aborting.";
    exit 1;
fi

### Update system clock
echo "Updating system clock . . ."
timedatectl set-ntp true
echo -e "Update complete.\n"

### Partition drive
echo "Paritioning drive . . ."
# use -s option for script mode
parted -s /dev/sda mklabel gpt \
    mkpart efi fat32 0% 300MiB \
    mkpart root ext4 300MiB 100% \
    set 1 esp on
echo "New partition table:"
parted -l
echo

### Format partitions
echo "Formatting partitions . . ."
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
echo -e "Format complete.\n"

### Installation 
echo "Installing packages . . . "
pacstrap /mnt base linux linux-firmware sudo vim dhcpcd curl
echo -e "Installation complete.\n"

### Configure system
echo "Configuring system . . ."
genfstab -U /mnt >> /mnt/etc/fstab

# Run subcript in chroot
arch-chroot /mnt $(curl -sL git.io/JkILq)

### Finished
echo -e "Installation Finished."

