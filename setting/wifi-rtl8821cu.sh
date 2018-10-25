# the process to install driver for Wifi USB with chip Realtek rtl8821cu:rtl8811cu.
# this do work for me (Tenda U9/TP-Link TL-WDN5200H)

# You may find that the official driver is only support WINDOWS systems.
# However, rtl8821cu driver can work on our chips (which is rtl8811cu).
# reference: https://github.com/MingxuZhang/rtl8821cu
# Download ./source/rtl8821cu.zip and decompress it, do:
make
sudo make install
sudo modprobe 8821cu

# If the device can not be detected, use `lsusb' to check device ID.
# For example, if the ID is something like 0bda:1a2b, do
sudo usb_modeswitch -KW -v 0bda -p 1a2b

# Now reboot system, the device should work.
reboot
