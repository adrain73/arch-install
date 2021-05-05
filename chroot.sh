#!/bin/bash

### Subscript to run in chroot environemnt

### Configure system
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime	
hwclock --systohc
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf 
echo "$hostname" >> /etc/hostname 
echo -e "127.0.0.1\t$hostname\n::1\t$hostname\n127.0.1.1\t$hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
echo "root:$pass1" | chpasswd

echo -e "Configuration complete.\n"

### Install bootloader
echo "Installing bootloader . . ."
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "Install complete.\n"
