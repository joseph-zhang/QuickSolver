# this file is about method of graphic control
# if your pc has two kinds of graphic card, for example, NVIDIA and Intel
# we know that NVIDIA is performanced but costly, this means, the method to switch between them is important
# Here we have two methods for this problem: 1.bbswitch 2.nvidia-prime(Recommended)

# first update imformation of your card
sudo update-pciids
# show hardware id, (rev ff) means this card is
lspci | grep -i VGA
# check hardware state
cat /proc/acpi/bbswitch

# FIRST METHOD. bbswitch
# bbswitch is a part of bumblebee. However you need not to install bumblebee, but just bbswitch
sudo modprobe bbswitch # load bbswitch module
tee /proc/acpi/bbswitch <<< OFF # turn off NVIDIV card
tee /proc/acpi/bbswitch <<< ON # turn on NVIDIV card
# check if the setting is correctly done 
dmesg |tail -1

# appendix. to control the performance of and reducing power, use tlp, remember to reboot after installation
sudo apt-get install tlp tlp-rdw
sudo tlp start
sudo tlp-stat # check tlp
sudo tlp ac # performanced mode
sudo tlp bat # energy-saving mode 
tlp diskid # check disk information

# SECOND METHOD. nvidia-prime (Recommended method)
# Actually, ubuntu has a support for NVIDIA card since 14.04, all we need to use nvidia-prime is click the mouse!
# you should first make sure what GPU driver you are using now.
# if you are using opensource driver(nouveau), you must find a proper version on nvidia website and install it.
# Now suppose you are using a proper driver for your own GPU card (example.mine : GTX1060 -> 384.98)
sudo apt-get install nvidia-prime # install nvidia-prime
# then install an indicator to switch GPU card
sudo add-apt-repository ppa:nilarimogard/webupd8  
sudo apt-get update  
sudo apt-get install prime-indicator
# Now we should add nouveau to blacklist
sudo gedit /etc/modprobe.d/blacklist.conf # open this file
# add a line in this file : blacklist nouveau
# Now reboot your computer, a new LOGO should appear on your system tray now!

