# change linux kernel version for upgrade or downgrade.
# first install the target kernel version, suppose the version is x.x.x-x

# install
sudo apt-get install linux-headers-x.x.x-x-generic linux-image-x.x.x-x-generic

# check the kernel order
grep 'menuentry' /boot/grub/grub.cfg

# modify grab default in file /etc/default/grub
GRUB_DEFAULT = the kernel order you want

# upgrade
sudo update-grub

# then reboot, check the kernel version
uname -a
