hostname=$(dialog --stdout --inputbox "Enter hostname" 0 0) || exit 1
: ${hostname:?"hostname cannot be empty"}

psswd1=$(dialog --stdout --passwordbox "Enter password" 0 0) || exit 1
psswd2=$(dialog --stdout --passwordbox "Reenter password" 0 0) || exit 1
[[ psswd1 == psswd 2 ]] || (echo "Passwords did not match"; exit 1;)

clear
