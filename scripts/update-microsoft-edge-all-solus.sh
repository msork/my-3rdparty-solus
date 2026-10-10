#!/bin/bash
# VARIABLES
ROOT_DIR="$HOME/pkgs/my-3rdparty-solus"
STABLE_VER=155.0.4283.45
BETA_VER=156.0.4314.15
DEV_VER=157.0.4322.0
CANARY_VER=157.0.4329.0

run_install() {
	# SETUP DIRECTORIES
	sudo rm -rf ~/Downloads/edge-"$1"-updater
	mkdir -p ~/Downloads/edge-"$1"-updater
	cd ~/Downloads/edge-"$1"-updater

	# COPY SCRIPT AND FILES
	wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/scripts/ep-update.py' -O ep-update.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/network/web/browser/microsoft-edge-"$1"/actions.py' -O actions.py
wget 'https://raw.githubusercontent.com/msork/my-3rdparty-solus/refs/heads/main/network/web/browser/microsoft-edge-"$1"/pspec.xml' -O pspec.xml

	# RUN SCRIPT
	chmod +x ep-update.py
	./ep-update.py "$2" "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-$1/microsoft-edge-$1_$2-1_amd64.deb"

	# BUILD AND INSTALL EOPKG
	sudo eopkg.py bi --ignore-safety pspec.xml
	sudo eopkg it -y ./*.eopkg

	# UPDATE PSPEC.XML
	cp ./pspec.xml $SCRIPTS/../network/web/browser/microsoft-edge-"$1"/pspec.xml
	echo "REMEMBER TO git add . -> git commit -m 'Updated microsoft-edge-$1' -> git push -u origin main"

	# REMOVE FILES
	sudo rm -rf ~/Downloads/edge-"$1"-updater
	sudo rm ~/Downloads/edge-"$1"-updater/*edge*.eopkg
}

run_install stable $STABLE_VER
run_install beta $BETA_VER
run_install dev $DEV_VER
run_install canary $CANARY_VER
