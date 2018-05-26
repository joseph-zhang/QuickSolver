# In fact, this is rarely met.
# After you upgrade the ubuntu system, the unity may collapse.
# The sidebar is disappeared, and GUI appears badly.

# First, check the compiz setting
ccsm
# if it is not installed, do
sudo apt install compizconfig-settings-manager

# find the item "Ubuntu Unity Plugin"
# if this is not exist, do
sudo apt install unity-tweak-tool
# then, execute
unity-tweak-tool --reset-unity
# if any error occur, try it in XTerm or UXTerm

# just enable "Ubuntu Unity Plugin" in ccsm
# then reboot.
