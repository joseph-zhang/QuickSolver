# appendix of graphic switching problem
# we have show that how to use nvidia-prime to switch GPU on ubuntu
# now we can find LOGO on system tray, warnning !!
# before switching to intel graphic card, you should make sure intel graphic driver is installed correctly!
# here we show how to install it by using intel-graphics-update-tool

# first find the proper version of this tool according to your own linux version
# and installed it from apt-get or deb package, for example
sudo dpkg -i intel-graphics-update-tool_2.0.2_amd64.deb  

# then add
wget $(echo "https://download".01.org/gfx/RPM-GPG-GROUP-KEY-ilg) -O - | sudo apt-key add -
wget --no-check-certificate https://download.01.org/gfx/RPM-GPG-KEY-ilg -O - | sudo apt-key add -
wget --no-check-certificate https://download.01.org/gfx/RPM-GPG-KEY-ilg-4 -O - | sudo apt-key add -
# update source
sudo apt-get update

# just open this tool and begin update, note that you may meet ppa problem when updating, just solve it.
# at last, reboot.
