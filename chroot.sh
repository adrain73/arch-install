### Subscript to run in chroot environemnt


### Configure system
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime	
hwclock --systohc
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf 
echo "$hostname" >> /etc/hostname 
echo -e "127.0.0.1\t$hostname\n::1\t$hostname\n120.0.1.1\t$hostname.localdomain $hostname"
mkinitcpio -P
echo "root:$pass1" | chpasswd

echo -e "Configuration complete.\n"
