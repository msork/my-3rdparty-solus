#!/bin/bash
# SETUP DIRECTORIES
SCRIPTS=$PWD
sudo rm -rf ~/Downloads/modrinth-updater
mkdir -p ~/Downloads/modrinth-updater
cd ~/Downloads/modrinth-updater

# SET VERSION
VERSION=0.21.6

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/games/modrinth-app/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/games/modrinth-app/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION https://launcher-files.modrinth.com/versions/${VERSION}/linux/Modrinth%20App_${VERSION}_amd64.deb

# BUILD AND INSTALL EOPKG
sudo eopkg.py bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# UPDATE PSPEC.XML
cp ./pspec.xml $SCRIPTS/../games/modrinth-app/pspec.xml
echo "REMEMBER TO git add . -> git commit -m 'Updated modrinth-app' -> git push -u origin main"

# REMOVE FILES
sudo rm -rf ~/Downloads/modrinth-updater
sudo rm ~/Downloads/modrinth-updater/modrinth-*.eopkg
