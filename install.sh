echo -n "Enter hostnam: "
read hostname
hostname="${hostname:?"Missing hostname"}"

echo -n "Enter password: "
read -s password1
echo
echo -n "Re-enter password: "
read -s password2
echo
[[ "$password1" == "$password2" ]] || (echo "Passwords did not match"; exit 1;)
