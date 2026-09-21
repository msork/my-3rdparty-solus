#!/bin/bash
# SETUP DIRECTORIES
ROOT_DIR="$HOME/pkgs/my-3rdparty-solus"
SCRIPTS="$ROOT_DIR/scripts"
sudo rm -rf ~/Downloads/moonlight-updater
mkdir -p ~/Downloads/moonlight-updater
cd ~/Downloads/moonlight-updater

# DOWNLOAD PKGBUILD FROM AUR AND EXTRACT VERSION
wget 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=moonlight-qt-bin' -O moonlight-qt-bin.PKGBUILD
VERSION=$(sed -n 3p moonlight-qt-bin.PKGBUILD | grep -Po '(?<=pkgver=)\d+\.\d+\.\d+')
rm moonlight-qt-bin.PKGBUILD

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/games/moonlight-qt/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/games/moonlight-qt/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION "https://github.com/moonlight-stream/moonlight-qt/releases/download/v$VERSION/Moonlight-$VERSION-x86_64.AppImage"

# BUILD AND INSTALL EOPKG
sudo eopkg.py bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# UPDATE PSPEC.XML
cp ./pspec.xml $ROOT_DIR/games/moonlight-qt/pspec.xml
echo "REMEMBER TO git add . -> git commit -m 'Updated moonlight-qt' -> git push -u origin main"

# REMOVE FILES
sudo rm -rf ~/Downloads/moonlight-updater
sudo rm ~/Downloads/moonlight-updater/moonlight-*.eopkg
