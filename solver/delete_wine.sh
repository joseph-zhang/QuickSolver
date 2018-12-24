# yay
yay -Rs wine
# yaourt
yaourt -Rs wine

# delete wine folder
sudo rm -r $HOME/.wine

# delete windows applications
rm -r $HOME/.local/share/applications

# delete residual windows programs
rm -r $HOME/.config/menus/applications-merged/wine*
