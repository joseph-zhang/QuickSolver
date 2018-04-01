# when update ppa source, a problem may occur:
# E: cannot download http://ppa.launchpad.net/fcitx-team/nightly/ubuntu/dists/xenial/main/binary-amd64/Packages  404 Not Found
# wo solve this problem, just do
cd /etc/apt/sources.list.d
mv fcitx-team-ubuntu-nightly-xenial.list fcitx-team-ubuntu-nightly-xenial.list.bak
sudo apt-get update
