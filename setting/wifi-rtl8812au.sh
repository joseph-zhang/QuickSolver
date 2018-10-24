# the process to install driver for Wifi USB with chip Realtek rtl8812au.
# this do work for me (Tenda U12)

# check device
lsusb

#--------------------------------------- Normal -----------------------------------------
# if the kernel version in range 2.6.18 ~ 4.4, 
# then we can use the normal installation which is provided by official Tenda.
# First download driver from official website and decompress it.
cd U12_linux_v5.1.5_19247.20160830/

# modify usb_intf.c
vim driver/rtl8812AU_linux_v5.1.5_19247.20160830/os_dep/linux/usb_intf.c
# add a line
# {USB_DEVICE(0x2604, 0x0012), .driver_info = RTL8812}, /* Tenda U12 */

# modify makefile
cd driver/rtl8812AU_linux_v5.1.5_19247.20160830/Makefile
# add a line
EXTRA_CFLAGS += -Wno-error=date-time

# installation
cd driver/rtl8812AU_linux_v5.1.5_19247.20160830/
make
sudo make install

#--------------------------------------- Appendix ---------------------------------------
# kernel version > 4.4 and do not want to downgrade kernel
# here is an alternative method (but not complete)

# installation
git clone https://github.com/gnab/rtl8812au.git
sudo cp -r rtl8812au /usr/src/rtl8812au-4.2.2
sudo dkms add -m rtl8812au -v 4.2.2
sudo dkms build -m rtl8812au -v 4.2.2
sudo dkms install -m rtl8812au -v 4.2.2

# After the installation, just reboot and check if the wireless work for us.
