# change linux kernel version for upgrade or downgrade.
# first install the target kernel version, suppose the version is x.x.x-x

# install
sudo apt-get install linux-headers-x.x.x-x-generic linux-image-x.x.x-x-generic

# check the kernel order
grep menuentry /boot/grub/grub.cfg

# modify grab default in file 
sudo vim /etc/default/grub
GRUB_DEFAULT = "the kernel order you want e.g. '1>2'"

# upgrade
sudo update-grub

# then reboot, check the kernel version
uname -a

#----------------------------------------------------------------
# Tips
#----------------------------------------------------------------
# If the setting of GRUB_DEFAULT is bad, you may not start
# the system directly, but start with some applications such
# as memory test. This is not an error, just press and hold
# "Shift" key, the grub will be shown on screen.
