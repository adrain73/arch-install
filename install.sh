#!/bin/bash

### Check for internet connection
echo "Checking for internet connection . . ."
# check with netcat 
if nc -dzw1 8.8.8.8 443; then
    echo "Connected. Proceeding."
    echo
else
    echo "No internet. Aborting.";
    exit 1;
fi
echo

### Update system clock
echo "Updating system clock . . ."
timedatectl set-ntp true
echo "Update complete."
echo

### Wipe drive
echo "Wiping drive . . ."
shred -vn1 /dev/sda
echo "Wipe complete."
echo

### Partition drive
echo "Paritioning drive . . ."
# use -s option for script mode
parted -s /dev/sda mklabel gpt
parted -s /dev/sda mkpart UEFI fat32 0% 300MiB
parted -s /dev/sda set 1 esp on
parted -s /dev/sda mkpart root ext4 300MiB 100%
echo "New partition table:"
parted -l
echo

### Format partitions
echo "Formatting partitions . . ."
mkfs.ext /dev/sda2
echo "Format complete."
echo

### Mount file system
echo "Mounting file system . . ."
mount /dev/sda2 /mnt
echo "Mount complete."
echo

### Installation 
echo "Installing packages . . . "
pacstrap /mnt base linux linux-firmware
echo "Installation complete."
echo

### Configure system
echo "Configuring system . . ."
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc
locale-gen
localectl set-locale LANG=en_US.UTF-8
echo "Configuration complete."
echo

### Get hostname
echo -n "Enter hostname: "
read hostname
hostname="${hostname:?"Missing hostname"}"
echo

### Get root password
echo -n "Enter root password: "
read -s rootpass1
echo
echo -n "Re-enter root password: "
read -s rootpass2
echo

### Check if the they match
if [ "$rootpass1" == "$rootpass2" ]; then
    :
else
    echo "Passwords did not match"; 
    exit 1;
fi

### Get username
echo -n "Enter username: "
read username
username="${username:?"Missing username"}"
echo 

### Get password
echo -n "Enter user password: "
read -s pass1
echo
echo -n "Re-enter user password: "
read -s pass2
echo

### Check if they match
if [ "$pass1" == "$pass2" ]; then
    :
else
    echo "Passwords did not match"; 
    exit 1;
fi

