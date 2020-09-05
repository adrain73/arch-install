#!/bin/bash

### Check for internet connection
echo "Checking for internet connection . . ."
# check with netcat 
if nc -zw1 8.8.8.8 443; then
    echo "Connected. Proceeding."
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
mkfs.ext4 /dev/sda2
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
hostnamectl set-hostname "$hostname"
echo

### Get root password
echo -n "Enter root password: "
read -s rootpass1
echo
echo -n "Re-enter root password: "
read -s rootpass2
if [ "$rootpass1" == "$rootpass2" ]; then
    :
else
    echo "Passwords did not match"; 
    exit 1;
fi
passwd "$rootpass1"
echo

### Install bootloader
echo "Installing bootloader . . ."
pacman -S grub efibootmgr
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB
echo "Install complete."
echo

### Enable microcode updates
echo "Enabling microcode updates . . ."
pacman -S amd-ucode intel-ucode
echo "Compelete"
echo

### Reboot to finish
exit
echo "Rebooting . . ."
reboot now

