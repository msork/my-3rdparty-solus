#!/bin/bash
# SETUP DIRECTORIES
sudo rm -rf ~/Downloads/curseforge-updater
mkdir -p ~/Downloads/curseforge-updater
cd ~/Downloads/curseforge-updater

# DOWNLOAD DEB AND EXTRACT VERSION
wget 'https://curseforge.overwolf.com/downloads/curseforge-latest-linux.deb' -O curseforge-latest-linux.deb
ar xf curseforge-latest-linux.deb
tar zxvf control.tar.gz ./control
VERSION=$(sed -n 2p control | grep -Po '(?<=Version: )\d+\.\d+\.\d+')
rm debian-binary data.tar.xz control control.tar.gz curseforge-latest-linux.deb

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/games/curseforge/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/games/curseforge/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION https://curseforge.overwolf.com/downloads/curseforge-latest-linux.deb

# BUILD AND INSTALL EOPKG
sudo eopkg bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# REMOVE FILES
sudo rm -rf ~/Downloads/curseforge-updater
sudo rm ~/Downloads/curseforge-updater/curseforge-*.eopkg
