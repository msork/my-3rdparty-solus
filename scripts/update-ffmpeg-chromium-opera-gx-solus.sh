#!/bin/bash
# VARIABLES
VERSION="108.0"
LIBZIP="0.$VERSION-linux-x64.zip"
WIDEVINECRX="oimompecagnajdejgnnjijobebaeigek_4.10.2934.0_linux_ph722a3wl2goebkpserszm6bde.crx3"

# SETUP DIRECTORIES
sudo rm -rf ~/Downloads/ffmpeg-chromium-opera-gx-updater
mkdir -p ~/Downloads/ffmpeg-chromium-opera-gx-updater
cd ~/Downloads/ffmpeg-chromium-opera-gx-updater

# COPY SCRIPT AND FILES
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/multimedia/codecs/ffmpeg-chromium-opera-gx/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/master/multimedia/codecs/ffmpeg-chromium-opera-gx/pspec.xml' -O pspec.xml

# RUN SCRIPT
chmod +x ep-update.py
./ep-update.py $VERSION "https://github.com/Ld-Hagen/nwjs-ffmpeg-prebuilt/releases/download/nwjs-ffmpeg-0.$VERSION/$LIBZIP" "https://www.google.com/dl/release2/chrome_component/accssjtqfpf5qicscrptql4jyyxa_4.10.2934.0/$WIDEVINECRX"

# BUILD EOPKG
sudo eopkg.py3 bi --ignore-safety pspec.xml

# UPDATE PSPEC.XML
cp pspec.xml $HOME/pkgs/my-3rdparty-solus/multimedia/codecs/ffmpeg-chromium-opera-gx/pspec.xml
echo "REMEMBER TO git add . -> git commit -m 'Updated ffmpeg-chromium-opera-gx-updater' -> git push -u origin master"

# COPY EOPKG
cp ~/Downloads/ffmpeg-chromium-opera-gx-updater/ffmpeg-chromium-opera-gx-$VERSION-2-1-x86_64.eopkg ~/Downloads/ffmpeg-chromium-opera-gx-$VERSION-2-1-x86_64.eopkg

# REMOVE FILES
sudo rm -rf ~/Downloads/ffmpeg-chromium-opera-gx-updater
sudo rm ~/Downloads/ffmpeg-chromium-opera-gx-updater/ffmpeg-chromium-opera-gx-updater-*.eopkg

# ECHO REMINDER TO INSTALL FFMPEG
echo "REMEMBER TO run the update-opera-gx-stable-solus.sh script before you install, if you haven't already."
