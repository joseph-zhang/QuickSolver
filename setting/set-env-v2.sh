# 2019/04/16
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

# Renewing Source (!!! never run -Sy below, but always use -Syu !!!)
sudo pacman -Sy # this step only synchronize packages, partial upgrades
# renew the whole system. Do not forget to add arch key
sudo pacman -Syu && sudo pacman -S archlinuxcn-keyring
# yaourt is old, we can install yay for replacing
sudo pacman -S yay
# try to use yay, for example, install typora
yay -S typora
# It works!
# Note that if you complete these renewing steps, the GPU driver may not match current system settings,
# don't worry about that, just reboot and the driver will upadate to the newest version.
# Moreover, if you like, octopi can be helpful for installing softwares.

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
# (5). OK, reboot and check if it works.
# If your setting is correct, the other monitor will work now.
# However, what is shown on that monitor is the same as primary one.
# Just use arandr to change the manner: save arandr setting in ~/.screenlayout and exec it in i3 config file.

# zsh and oh-my-zsh
# zsh is pre-installed in my i3 version, but oh-my-zsh setting is still needed.
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# DNS setting for github
# modify /etc/hosts, append the following lines
192.30.253.112 github.com
192.30.253.113 github.com
151.101.184.133 assets-cdn.github.com
151.101.185.194 github.global.ssl.fastly.net
# then restart DNS
sudo systemctl restart NetworkManager.service

# Startup settings
# - wallpaper setting
exec --no-startup-id feh --bg-scale "$HOME/Pictures/wallpaper/wallpaper.jpg"
# if this not work, set a picture in lightdm-settings, and delete default background pictures
sudo rm /usr/share/backgrounds/*
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

# Conky prompt information
# If you don't want to show prompt inforamtions about i3wm,
# just modify /usr/share/conky/conkyxx_shortcuts_maia, comment those lines in conky.text
# you can also change the color in conky_maia, recommend #FAEBD7

# Close Beep
# Beep is noisy. To close it, use this command
sudo rmmod pcspkr

# Some modern linux command
sudo pacman -S fd
sudo pacman -S exa
sudo pacman -S bat
# and do not forget to set alias in bashrc or zshrc
alias ls='exa'
alias find='fd'
alias cat='bat'

# Install python env - via Anaconda
# First download installation file, recommend to search the install file from a mirror site (e.g. USTC Mirror)
# Then, follow the install steps on "http://docs.anaconda.com/anaconda/install/linux/"
# Don't forget to add install location to PATH in $HOME/.zshrc, we can copy that from $HOME/.bashrc
source ~/.zshrc
# Try it now:
conda info --envs # or `conda env list`
conda list
# So the Anaconda is installed.
# We can also reset the source:
conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
# Try it again, the download is very fast now.
########################################################################################
## *TIPs*                                                                             ##
## - check installed packages of current env: `conda list`                            ##
## - check existing envs: `conda env list`                                            ##
## - create a new env with some packages: `conda create -n "env-name" xxx xxx ...`    ##
## - create a new env by yaml file: `conda env create -f xxx.yaml`                    ##
## - export env configuration as yaml: `conda env export > xxx.yaml`                  ##
## - change current active env: `conda activate "env-name"`                           ##
## - leave current env: `conda deactivate`                                            ##
## - delete a specific env: `conda env remove -n "env-name"`                          ##
## - remove cached package tarballs: `conda clean -t`                                 ##
## - remove unused cached packages: `conda clean -p`                                  ##
## - update packages of current env: `conda update xxx`                               ##
## - install new packages to current env: `conda install xxx`                         ##
## - remove packages from current env: `conda remove xxx`                             ##
########################################################################################

# Install Cuda & Cudnn
# This step is very relaxed under manjaro!
# Just use yay or yaourt.
# Here is an example of cuda10 & cudnn7, the version is up to you.
# - install cuda:
yay -S cuda-10.0 # v-10.0 is the newest version, if this not work, just use yay -S cuda
# then add Paths to ~/.zshrc
export CUDA_HOME=/opt/cuda
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
# check cuda runtime version
nvcc -V
# check with an example
cd /opt/cuda/samples/1_Utilities/deviceQuery
sudo make
./deviceQuery
# - install cudnn:
yay -S cudnn7 # as before, if this not work, just use yay -S cudnn
# Done. reboot.

# Font settings
# First install Iosevka and Sarasa-Gothic
sudo pacman -S ttf-iosevka-cc-slab ttf-sarasa-gothic
# set i3-bar font, modify $HOME/.i3/config
font xft:IosevkaCC Slab 11
# then, set Urxvt font, modify ~/.Xresources
URxvt.font:xft:IosevkaCC Slab:antialias=True:pixelsize=15
# and renew Urxvt
xrdb -load ~/.Xresources
# If some command cannot work, with error 'rxvt-unicode-256color': unknown terminal type.
# Just modify ~/.zshrc, adding the following line.
export TERM='xterm-256color'
# install some other font packages
sudo pacman -S adobe-source-han-serif-cn-fonts adobe-source-han-serif-tw-fonts adobe-source-han-serif-jp-fonts
yay -S ttf-ms-fonts
yay -S ttf-mac-fonts
# Enjoy new fonts!

# Install TeXLive
sudo pacman -S texlive-most texlive-lang

# Optional: guake terminal
# another choice
sudo pacman -S guake
# and set zsh as the interpreter && iosevka font && theme::Tomorrow Night && i3 key-binding

# Optional: nvm for JSer
sudo pacman -S nvm
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
exec $SHELL
# after nvm is installed, use following code to install latest release of node
nvm install node
# then use
nvm use node
# to check the node version. the npm should also be installed correctly.
npm -v
# to check the installed instances of nvm, just use
nvm ls
# If you need Typescript
npm install -g typescript

# Optional: ruby for rubyist
sudo pacman -S ruby
gem sources --add https://gems.ruby-china.com/ # replace to China gem source
gem sources --remove http://rubygems.org/ # delete old source
gem install rails
gem install jekyll
gem install bundler # If you don't have bundler installed
gem install github-pages
gem install kramdown

# Deep Learning env
# for example, we can use conda to create a tensorflow environment
conda create -n tensorflow_gpuenv tensorflow-gpu
# activate this environment
conda activate tensorflow_gpuenv
# Then just install packages you want by using
conda install XXX # e.g. conda install matplotlib
# !! HOWEVER, I recommend to build envs from yml config file directly,
# there is a pytorch example in torch.yml

# Haskell env
sudo pacman -S stack
sudo pacman -S ghc
# then change source, reference:
# Stackage: https://mirrors.ustc.edu.cn/help/stackage.html
# Hackage: https://mirrors.ustc.edu.cn/help/hackage.html

# Racket
sudo pacman -S racket

# Rust
# Following the official method: https://www.rust-lang.org/tools/install
curl https://sh.rustup.rs -sSf | sh
# and add the path to zshrc.
# then install racer
cargo install racer
# note that you may meet the error like this:
"#![feature] may not be used on the stable release channel"
# To overcome, you can try nightly rust
rustup install nightly
cargo +nightly install racer
# then add source code
rustup component add rust-src

# Ocaml & Coq
# Following links below:
# Ocaml: https://ocaml.org/docs/install.html
# Opam: https://opam.ocaml.org/doc/Install.html
pacman -S ocaml
pacman -S opam
# then coq: https://coq.inria.fr/opam/www/using.html
export OPAMROOT=~/.opam # installation directory
opam init -n --comp=4.02.3 -j 2 # 2 is the number of CPU cores (can be changed)
opam repo add coq-released http://coq.inria.fr/opam/released
opam install coq.8.8.1 && opam pin add coq 8.8.1
# to run coq, don't forget to add opam path to zshrc.
# check coq version
coqc -v
# current ocaml version (4.02.3) is just for coq,
# hence we also install a newer compiler version (e.g. 4.04.1)
opam switch create 4.04.1
eval $(opam env)
# Now install some useful packages
opam update
opam install core
opam install merlin
opam install utop
opam install tuareg
opam install ocp-indent
# Then, follow this link to set utop: https://dev.realworldocaml.org/install.html
# note: (1). use `opam switch 'version'` to change ocaml base compiler version.
#       (2). just use `opam switch` to check ocaml version list.
#       (3). use `opam switch remove 'version'` to wipe a version and all its packages.
#       (4). use `opam config var share` to check package path.

# OpenGL related Libs
# First we build and install GLFW (instead of old GLUT)
# Download source code from https://www.glfw.org/download.html
# Now cd to that folder, and follow these steps:
mkdir build
cd build
cmake ..
make
sudo make install
# Now GLFW has been installed.
# Then we should try it with examples.
# If get an error like "usr/bin/ld: cannot find -lglfw3",
# Then you should check if install destination is /usr/local/lib64 (while we need /usr/local/lib)
# If so, just move them to /usr/local/lib, the problem should be solved.
# Now we install GLAD.
# First download a proper version from http://glad.dav1d.de/
# note that we should choose these options:
#    Language: 'C/C++'
#    Specification: 'OpenGL'
#    API::gl: 'version xxx' (xxx >= 3.3)
#    Profile: 'Core'
# and then it will give us a folder that contains /include and /src,
# move things in /include to /usr/local/include.
# Note that the C file glad.c in /src should be used as project file.
# Install GLM lib
sudo pacman -S glm

# Install Mathematica
# check this page to install: http://support.wolfram.com/kb/12453?lang=en
# There may exist some compatibility issues like this:
# "Symbol lookup error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var"
# To solve this problem, following archwiki:
cd <INSTALL_DIR>/SystemFiles/Libraries/Linux-x86-64
mv libfreetype.so.6 libfreetype.so.6.old
mv libz.so.1 libz.so.1.old

# optional: Julia installation
# First download the binary files from one of:
# 1). offical: https://julialang.org/downloads/ (may be very slow)
# 2). mirrors (e.g. USTC): http://mirrors.ustc.edu.cn/julia/
# then decompress the package to a path (up to you)
# and add your julia path to bashrc or zshrc PATH.
source ~/.zshrc
# check julia version
julia -version
# !!! another recommend method is just use pacman
sudo pacman -S julia
