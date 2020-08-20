# Get names
echo -n "Enter hostnam: "
read hostname
hostname="${hostname:?"Missing hostname"}"

# Get root password
echo -n "Enter root password: "
read -s rootpass1
echo
echo -n "Re-enter root password: "
read -s rootpass2
echo
[[ "$rootpass1" == "$rootpass2" ]] || (echo "Passwords did not match"; exit 1;)

