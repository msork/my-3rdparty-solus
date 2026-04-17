#!/bin/bash
# SETUP DIRECTORIES
SCRIPTS=$PWD
sudo rm -rf ~/Downloads/modrinth-updater
mkdir -p ~/Downloads/modrinth-updater
cd ~/Downloads/modrinth-updater

# DOWNLOAD DEB AND EXTRACT VERSION
wget 'https://launcher-files.modrinth.com/versions/0.13.1/linux/Modrinth%20App_0.13.1_amd64.deb' -O ModrinthApp_0.13.1_amd64.deb
ar xf ModrinthApp_0.13.1_amd64.deb
tar zxvf control.tar.gz ./control
VERSION=$(sed -n 2p control | grep -Po '(?<=Version: )\d+\.\d+\.\d+')
rm debian-binary data.tar.gz control.tar.gz ModrinthApp_0.13.1_amd64.deb

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/games/modrinth-app/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/games/modrinth-app/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION https://launcher-files.modrinth.com/versions/0.13.1/linux/Modrinth%20App_0.13.1_amd64.deb

# BUILD AND INSTALL EOPKG
sudo eopkg.py3 bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# UPDATE PSPEC.XML
cp ./pspec.xml $SCRIPTS/../games/modrinth-app/pspec.xml
echo "REMEMBER TO git add . -> git commit -m 'Updated modrinth-app' -> git push -u origin master"

# REMOVE FILES
sudo rm -rf ~/Downloads/modrinth-updater
sudo rm ~/Downloads/modrinth-updater/modrinth-*.eopkg
