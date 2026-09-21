#!/bin/bash
# SETUP DIRECTORIES
SCRIPTS=$PWD
sudo rm -rf ~/Downloads/curseforge-updater
mkdir -p ~/Downloads/curseforge-updater
cd ~/Downloads/curseforge-updater

# DOWNLOAD DEB AND EXTRACT VERSION
wget 'https://curseforge.overwolf.com/downloads/curseforge-latest-linux.deb' -O curseforge-latest-linux.deb
ar xf curseforge-latest-linux.deb
tar xvf control.tar.xz ./control
VERSION=$(sed -n 2p control | grep -Po '(?<=Version: )\d+\.\d+\.\d+')
rm debian-binary data.tar.xz control control.tar.xz curseforge-latest-linux.deb

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/games/curseforge/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/games/curseforge/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION https://curseforge.overwolf.com/downloads/curseforge-latest-linux.deb

# BUILD AND INSTALL EOPKG
sudo eopkg.py bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# UPDATE PSPEC.XML
cp ./pspec.xml $SCRIPTS/../games/curseforge/pspec.xml
echo "REMEMBER TO git add . -> git commit -m 'Updated curseforge' -> git push -u origin main"

# REMOVE FILES
sudo rm -rf ~/Downloads/curseforge-updater
sudo rm ~/Downloads/curseforge-updater/curseforge-*.eopkg
