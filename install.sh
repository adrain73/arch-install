#!/bin/bash

### Check for internet connection
echo "Checking for internet connection . . ."
if nc -zw1 8.8.8.8 443; then
    echo -e "Connected. Proceeding.\n"
else
    echo "No internet. Aborting.";
    exit 1;
fi

### Get hostname and password from user
read -p "Enter hostname: " hostname >/dev/tty
if [ -z "$hostname" ]; then
    echo "Hostname cannot be empty!";
    exit 1;
fi
echo
read -p "Enter root password: " -s pass1 >/dev/tty
echo
read -p "Re-enter root password: " -s pass2 >/dev/tty
if [ "$pass1" == "$pass2" ]; then
    :
else
    echo "Passwords did not match!";
    exit 1;
fi
echo

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
pacstrap /mnt base linux linux-firmware vim dhcpcd
echo -e "Installation complete.\n"

### Configure system
echo "Configuring system . . ."
genfstab -U /mnt >> /mnt/etc/fstab
function config {
    ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime	
    hwclock --systohc
    locale-gen
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf 
    echo "$hostname" >> /etc/hostname 
    echo -e "127.0.0.1\t$hostname\n::1\t$hostname\n120.0.1.1\t$hostname.localdomain $hostname"
    mkinitcpio -P
    echo "root:$pass1" | chpasswd
}
arch-chroot /mnt config
echo -e "Configuration complete.\n"

### Install bootloader
echo "Installing bootloader . . ."
function boot {
    pacman -S grub efibootmgr
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg

}
arch-chroot /mnt boot
echo -e "Install complete.\n"

### Reboot to finish
echo "Rebooting . . ."
umount -R /mnt
reboot now

