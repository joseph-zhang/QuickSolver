## install utorrent ##
sudo apt-get update
sudo apt-get install libssl1.0.0 libssl-dev

# download recent release
wget http://download-new.utorrent.com/endpoint/utserver/os/linux-x64-ubuntu-13-04/track/beta/ -O utserver.tar.gz
# change the permission of this dir
sudo chmod 777 /opt/utorrent-server-alpha-v3_3/
# create a link
sudo ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver

# start utorrent
utserver -settingspath /opt/utorrent-server-alpha-v3_3/

# and then, utorrent will run on http://localhost:8080/gui #
