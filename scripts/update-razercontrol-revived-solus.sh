#!/bin/bash
# VARIABLES
ROOT_DIR="$HOME/pkgs/my-3rdparty-solus"

# SETUP DIRECTORIES
sudo rm -rf ~/Downloads/razer-updater
mkdir -p ~/Downloads/razer-updater
cd ~/Downloads/razer-updater

# DOWNLOAD DEB AND EXTRACT VERSION
VERSION=0.3.5

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/system/utils/razercontrol-revived/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/system/utils/razercontrol-revived/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION "https://github.com/encomjp/razercontrol-revived/releases/download/v$VERSION/razercontrol-revived_${VERSION}_amd64.deb"

# BUILD AND INSTALL EOPKG
sudo eopkg.py bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# UPDATE PSPEC.XML
cp ./pspec.xml $SCRIPTS/../system/utils/razercontrol-revived/pspec.xml
echo "REMEMBER TO git add . -> git commit -m 'Updated razercontrol-revived' -> git push -u origin main"

# REMOVE FILES
sudo rm -rf ~/Downloads/razer-updater
sudo rm ~/Downloads/razer-updater/razercontrol-revived-*.eopkg
