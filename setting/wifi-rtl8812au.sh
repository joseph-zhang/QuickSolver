# the process to install driver for Wifi USB with chip Realtek rtl8812au.
# this do work for me (Tenda U12)

git clone https://github.com/gnab/rtl8812au.git
sudo cp -r rtl8812au /usr/src/rtl8812au-4.2.2
sudo dkms add -m rtl8812au -v 4.2.2
sudo dkms build -m rtl8812au -v 4.2.2
sudo dkms install -m rtl8812au -v 4.2.2


#--------------------------------------- appendix ----------------------------------------
# method to install Realtek RTL8723de
git clone https://github.com/lwfinger/rtlwifi_new.git
cd rtlwifi_new
make
sudo make install

# After the installation, just reboot and check if the wireless work for us.
