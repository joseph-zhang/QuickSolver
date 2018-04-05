# after a few times kernel update, the space of boot may be not enough
# the reason is that many old version kernels are still installed.
# so the solution is uninstall some of them

# check what are they
dpkg --get-selections |grep linux-image

# check which one you are using now
uname -a

# uninstall one of them which you don't need any more
# note that <***> here is the image you select
sudo apt-get purge <***> 

# don't forget to check header files, and delete the conresponding one
# note that <***> here is the header you select
sudo apt-get purge <***>
