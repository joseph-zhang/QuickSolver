# 2018/12/19
# Another development environment setting memo.
# System OS : Manjaro
# DE : no DE :)
# WM : i3
# CPU : Intel Core i7-6700
# GPU : Geforce GT 730
#------------------------------------------------------
# fonts:
#     system: sarasa-mono-sc-regular
#     editor: iosevka-cc-slab-extralight
#     CJK for latex: Source Han Serif SC
#------------------------------------------------------

# **Installation**
# First install Manjaro (WM or DE) from mirror file.
# If you cannot see anything on screen, perhaps you should set GPU driver 'nonfree' instead of installing open-source one.
# Then, just divide the disk space as what you did before when installing other Linux releases.
# Wait a moment, the installation will be done.
# After installation, you can find the corresponding GPU information in screenfetch result,
# we need not to install GPU driver by ourselves, manjaro has done it for us.

# Setting Package Source
# you can list all mirrors by using
sudo pacman-mirrors -g
# here I just use China mirror, hence just do
sudo  pacman-mirrors -i -c China -m rank
# and select one from the mirror list.
# you may also need arch Source, hence do something to set archlinux source
sudo vim /etc/pacman.conf # open this file for modifying
# here I add two lines below in this file
# [archlinuxcn]
# Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch

# Renewing Source
sudo pacman -Syy # this step only synchronize packages
# renew the whole system. Do not forget to add arch key
sudo pacman -Syyu && sudo pacman -S archlinuxcn-keyring
# yaourt is old, we can install yay for replacing
sudo pacman -S yay
# try to use yay, for example, install typora
yay -S typora
# It works!
# Note that if you complete these renewing steps, the GPU driver may not match corrent system settings,
# don't worry about that, just reboot and the driver will upadate to the newest version, as well as CUDA version.

# NOW LET US SOLVE A BIG PROBLEM
# If you have multiple monitors, you may find that only one of them is working now.
# How to lighting another monitor?
# First check
lspci | grep VGA
# Here I only find single NVIDIA device, Intel one is not found!
# Hence, if I use the official recommended bumblebee, it will not work.
# In another way, I can use Nvidia as primary output source instead of Intel, so try Nvidia-Prime.
# [Reference]: https://forum.manjaro.org/t/howto-set-up-prime-with-nvidia-proprietary-driver/40225
# (1). Install nvidia driver (do this if you select 'free' when installing system. Just skip this step if 'non-free' was seleted.)
sudo mhwd -i pci video-nvidia
# (2). Revise mhwd settings
# - delete /etc/X11/xorg.conf.d/90-mhwd.conf
# - create a new 90-mhwd.conf that contains
# ---------------------------------------------------
Section "Module"
    Load "modesetting"
EndSection

Section "Device"
    Identifier "nvidia"
    Driver "nvidia"
    BusID "PCI:1:0:0"
    Option "AllowEmptyInitialConfiguration"
EndSection
# ----------------------------------------------------
# Note that the BusId should be replaced, check lspci | grep -E "VGA|3D"
# (3). Reset blacklist and enable nvidia-drm.modeset
# - delete two files under /etc/modprobe.d/
sudo rm /etc/modprobe.d/mhwd-gpu.conf
sudo rm /etc/modprobe.d/mhwd-nvidia.conf
# - create /etc/modprobe.d/nvidia.conf that contains
# -----------------------------------------------------
blacklist nouveau
blacklist nvidiafb
blacklist rivafb
# -----------------------------------------------------
# - create /etc/modprobe.d/nvidia-drm.conf that contains
# -----------------------------------------------------
options nvidia_drm modeset=1
# -----------------------------------------------------
# (4). Set Lightdm display output source
# - create a file /usr/local/bin/optimus.sh that contains
# -----------------------------------------------------
#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
# -----------------------------------------------------
# and set this
sudo chmod a+rx /usr/local/bin/optimus.sh
# - modify /etc/lightdm/lightdm.conf, adding the following line to [Seat:*] term
display-setup-script=/usr/local/bin/optimus.sh
# (5). OK, reboot and check if it work.
# If your setting is correct, the other monitor will work now.
# However, what is shown on that monitor is the same as primary one.
# Just use arandr to change the manner: save arandr setting in ~/.screenlayout and exec it in i3 config file.

# zsh and oh-my-zsh
# zsh is pre-installed in my i3 version, but oh-my-zsh setting is still needed.
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Startup settings
# - wallpaper setting
exec --no-startup-id feh --bg-scale "$HOME/Pictures/wallpaper/wallpaper.jpg"
# if this not work, set a picture in lightdm-settings
# - Using compton to set transparent. Just modify ~/.config/compton.conf, uncomment opacity terms.
# don't forget to install feh
pacman -S feh

# Chinese support
sudo pacman -S fcitx-im # full selection
sudo pacman -S fcitx-configtool
sudo pacman -S fcitx-sogoupinyin
# then add the following lines in ~/.xprofile
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
exec fcitx &
