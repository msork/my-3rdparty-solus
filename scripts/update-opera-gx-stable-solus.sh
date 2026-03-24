#!/bin/bash
# VARIABLES
FILE="opera_gx_stable-128.0.5807.97-linux-release-x64-signed.rpm"
DEBFILE="opera-gx-stable_128.0.5807.97_amd64.deb"

# SETUP DIRECTORIES
sudo rm -rf ~/Downloads/opera-gx-stable-updater
mkdir -p ~/Downloads/opera-gx-stable-updater
cd ~/Downloads/opera-gx-stable-updater

# DOWNLOAD RPM AND EXTRACT IT
wget 'https://rpm.opera.com/rpm/'$FILE -O $FILE
wget 'https://deb.opera.com/opera/pool/non-free/o/opera-gx-stable/'$DEBFILE -O $DEBFILE
rpm2cpio $FILE | cpio -idmv

# DOWNLOAD DEB AND EXTRACT VERSION
ar -xvf $DEBFILE
tar -xvf control.tar.xz
VERSION=$(sed -n 2p control | grep -Po '(?<=Version: )\d+(?:\.\d+)*' | cut -d' ' -f2)
rm debian-binary data.tar.xz control control.tar.xz $DEBFILE $FILE

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/network/web/browser/opera-gx-stable/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/network/web/browser/opera-gx-stable/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION "https://rpm.opera.com/rpm/$FILE"

# BUILD AND INSTALL EOPKG
sudo eopkg.py3 bi --ignore-safety pspec.xml
sudo eopkg it -y ./*.eopkg

# UPDATE PSPEC.XML
cp pspec.xml $HOME/pkgs/my-3rdparty-solus/network/web/browser/opera-gx-stable/pspec.xml
echo "REMEMBER TO git add . -> git commit -m 'Updated opera-gx-stable' -> git push -u origin master"

# REMOVE FILES
sudo rm -rf ~/Downloads/opera-gx-stable-updater
sudo rm ~/Downloads/opera-gx-stable-updater/opera-gx-stable-*.eopkg
