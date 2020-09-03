#!/bin/bash

### Check for internet
echo "Checking for internet connection . . ."
# check with netcat 
if nc -dzw1 8.8.8.8 443; then
	echo "Connected. Proceeding."
else
	echo "No internet. Aborting.";
	exit 1;
fi

### Wipe drive
echo "Wiping drive . . ."
shred -vn1 /dev/sda
echo "Wipe complete."

### Partition drive
echo "Paritioning drive . . ."
# user -s option for script mode
parted -s /dev/sda mklabel gpt
parted -s /dev/sda mkpart UEFI fat32 0% 300MiB
parted -s /dev/sda set 1 esp on
parted -s /dev/sda mkpart root ext4 300MiB 100%
echo "New partition table:"
parted -l

# Get hostname
echo -n "Enter hostname: "
read hostname
hostname="${hostname:?"Missing hostname"}"

# Get root password
echo -n "Enter root password: "
read -s rootpass1
echo
echo -n "Re-enter root password: "
read -s rootpass2
echo

# check if the they match
if [ "$rootpass1" == "$rootpass2" ]; then
	:
else
	echo "Passwords did not match"; 
	exit 1;
fi

# Get username
echo -n "Enter username: "
read username
username="${username:?"Missing username"}"

# Get password
echo -n "Enter user password: "
read -s pass1
echo
echo -n "Re-enter user password: "
read -s pass2
echo

# Check if they match
if [ "$pass1" == "$pass2" ]; then
	:
else
	echo "Passwords did not match"; 
	exit 1;
fi

