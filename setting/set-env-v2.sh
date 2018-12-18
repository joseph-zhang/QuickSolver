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
sudo pacman -Syu # renew the whole system
# do not forget to add arch key
sudo pacman -Syy && sudo pacman -S archlinuxcn-keyring
# yaourt is old, we can install yay
sudo pacman -S yay
# try to use yay, perhaps we can install typora
yay -S typora
# It works!

# zsh and oh-my-zsh
# zsh is pre-installed in my i3 version, but oh-my-zsh setting is still needed.
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
