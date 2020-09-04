# Arch Install Script

### About Arch
Arch Linux is a minimal gnu/linux distribution.
For more information about Arch see their [documentation.](https://www.archlinux.org/)

For more information about what goes into installing Arch see the [Installation guide.](https://wiki.archlinux.org/index.php/installation_guide)
I generally recommend fist time users try to install Arch themselves.
This will give a good introduction to the operating system, how to read the wiki, and what to expect with Arch.
This script is meant mostly for users who have already completed this themselves and what a hands off approach.

Arch is a very hands on operating system and requires a lot of knowledge and time for the user to properly use.
It is generally not advised as a first linux distribution to try.
For first time linux users or users wanting to get a more user friendly Arch based distrobution consider trying [Manjaro Linux.](https://manjaro.org/)

## The Script
This is a bash script meant to complete automate an installation of Arch Linux.
You can see the raw file of the install.sh with this short url: https://git.io/JUYmw

To complete the installation you will need to create a bootable media for the live installation.
Details on how to do that can be found [here.](https://wiki.archlinux.org/index.php/installation_guide#Boot_the_live_environment)

From the live installation you can run this command to download the script to a text file:
` curl -L https://git.io/JUYwm -O `

Before you run the script it it required that you are connected to the internet.
If you are not connected the script will abort the installation.
For more information about how to connect Arch to a network see [here.](https://wiki.archlinux.org/index.php/installation_guide#Connect_to_the_internet)

You will then need to modify the file to be able to execute with this command: ` chmod +x JUYmw `

Then you can run the script with this command: ` ./JUYmw '

### Partitioning
**Warning: this script wipes the main storage before creating partitions**

The script creates drive partitions meant for UEFI systems.
It creates two partitions: A 300MiB EFI system partition and a root partition in the rest of the drive.

### Packages
The script currently will only install the base package.
This package does **not** contain the same packages as the live installation.
More packages may later be added.
