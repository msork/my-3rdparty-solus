#!/bin/bash
# VARIABLES
FILE="librewolf-143.0.4-1-linux-x86_64-deb.deb"

# SETUP DIRECTORIES
sudo rm -rf ~/Downloads/librewolf-updater
mkdir -p ~/Downloads/librewolf-updater
cd ~/Downloads/librewolf-updater

# DOWNLOAD DEB AND EXTRACT VERSION
wget 'https://repo.librewolf.net/pool/'$FILE -O $FILE.deb
ar xf $FILE
tar -xvf control.tar.xf
VERSION=$(sed -n 12p control | grep -Po '(?<=Version: )\d+(?:\.\d+)*' | cut -d'-' -f1)
rm debian-binary data.tar.xf control control.tar.xf $FILE

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/network/web/browser/librewolf/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/network/web/browser/librewolf/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION https://repo.librewolf.net/pool/$FILE

# BUILD AND INSTALL EOPKG
sudo eopkg bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# REMOVE FILES
#sudo rm -rf ~/Downloads/librewolf-updater
#sudo rm ~/Downloads/librewolf-updater/librewolf-*.eopkg
