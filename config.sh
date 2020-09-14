#!/bin/bash

### Secondary script for configuration
datetimectl set-timezone America/Chicago
hwclock --systohc
locale-gen
localectl set-locale LANG=en_US.UTF-8
hostnamectl set-hostname "$hostname"
mkinitcpio -P
systemctl enable dhcpcd
systemctl enable gdm.service
systemctl enable NetworkManager.service
echo "root:$pass1" | chpasswd
