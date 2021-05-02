# Arch Install Script

## About Arch
Arch Linux is a minimal gnu/linux distribution.
For more information about Arch see their [documentation.](https://www.archlinux.org/)

For more information about what goes into installing Arch see the [installation guide.](https://wiki.archlinux.org/index.php/installation_guide)
This script mostly follows the steps in the guide in the order they are listed.

## The Script
This is a bash script meant to almost completely automate an installation of Arch Linux.
You can see the raw file of the install.sh with this short url: https://git.io/JUYmw

To complete the installation you will need to create a bootable media for the live installation.
Details on how to do that can be found [here.](https://wiki.archlinux.org/index.php/installation_guide#Boot_the_live_environment)

Before you run the script it it required that you are connected to the internet.
If you are not connected the script will abort the installation.
For more information about how to connect Arch to a network see [here.](https://wiki.archlinux.org/index.php/installation_guide#Connect_to_the_internet)

To run the script you can simple run this command to get started:
` curl -L git.io/JUYmw | bash `

Once this runs you will need to enter in a host name and a password for the root user and then the script will start the installation process.

### Modifying the script 

In some cases the user may want to make some changes to the installation script before installation. 
This could be usefully to add packages that you want installed to the script.
Or you could change the partitioning table or device name needed. 

From the live installation you can run this command to download the script to a text file:\
` curl -L https://git.io/JUYwm -O `

You can then modify the script in anyway you please using the prefered text editor on the installtion media. 

You will then need to modify the file to be able to execute with this command:\
` chmod +x JUYmw `

Then you can run the script with this command:\
` ./JUYmw `

### Partitioning
**Warning: this script wipes the main storage before creating partitions**

The script creates drive partitions meant for UEFI systems.
It creates two partitions: A 300MiB EFI system partition and a root partition in the rest of the drive.

### Packages
The script currently will only install the base package.
This package does **not** contain the same packages as the live installation.
More packages may later be added.
