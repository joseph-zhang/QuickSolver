# a solution for error state -> dpkg :: error for dealing with package XXX ..
sudo mv /var/lib/dpkg/info /var/lib/dpkg/info_old
sudo mkdir /var/lib/dpkg/info
sudo apt-get update
sudo apt-get -f install
sudo mv /var/lib/dpkg/info/* /var/lib/dpkg/info_old
sudo rm -rf /var/lib/dpkg/info
sudo mv /var/lib/dpkg/info_old /var/lib/dpkg/info
