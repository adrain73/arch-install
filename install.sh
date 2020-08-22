#!/bin/bash

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

