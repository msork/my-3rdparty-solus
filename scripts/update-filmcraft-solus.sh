#!/bin/bash
VERSION=0.8.0
#PKG_ROOT=

# SETUP DIRECTORIES
sudo rm -rf ~/Downloads/filmcraft-updater
mkdir -p ~/Downloads/filmcraft-updater
cd ~/Downloads/filmcraft-updater

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/multimedia/video/filmcraft/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/multimedia/video/filmcraft/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION "https://github.com/storytold/filmcraft/releases/download/v$VERSION/filmcraft-$VERSION-linux-x86_64.deb"

# BUILD AND INSTALL EOPKG
sudo eopkg.py bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# UPDATE PSPEC.XML
#cp ./pspec.xml $SCRIPTS/../multimedia/video/filmcraft/pspec.xml
echo "REMEMBER TO git add . -> git commit -m 'Updated filmcraft' -> git push -u origin main"

# REMOVE FILES
sudo rm -rf ~/Downloads/filmcraft-updater
sudo rm ~/Downloads/filmcraft-updater/filmcraft-*.eopkg
