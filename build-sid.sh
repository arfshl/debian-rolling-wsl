#!/bin/sh

# export the env
export RELEASE=sid
ARCH=$(uname -m)
case "$ARCH" in
    x86_64) ARCH=amd64 ;;
    amd64) ARCH=amd64 ;;
    aarch64) ARCH=arm64 ;;
    arm64) ARCH=arm64 ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac
echo "RELEASE=$RELEASE" >> "$GITHUB_OUTPUT"
echo "ARCH=$ARCH" >> "$GITHUB_OUTPUT"

# install depedencies
curl -L -o /tmp/mmdebstrap.deb http://ftp.us.debian.org/debian/pool/main/m/mmdebstrap/mmdebstrap_1.5.7-3_all.deb
sudo apt install -yq /tmp/mmdebstrap.deb
curl -L -o /tmp/keyring.deb http://ftp.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2025.1_all.deb
sudo apt install -yq /tmp/keyring.deb

# start build with mmdebstrap and sprays some WD-40 to get rid of rust on coreutils
dist_version="$RELEASE"

sudo mmdebstrap \
--arch=$ARCH \
--variant=apt \
--components="main,contrib,non-free" \
--include=locales,passwd,ca-certificates,sudo,libpam-systemd,dbus,systemd,mesa-utils,systemd-sysv \
--format=directory \
${dist_version} \
debian-sid \

cat <<-EOF | sudo unshare -mpf bash -e -
sudo mount --bind /dev ./debian-sid/dev
sudo mount --bind /proc ./debian-sid/proc
sudo mount --bind /sys ./debian-sid/sys
sudo echo 'nameserver 1.1.1.1' >> ./debian-sid/etc/resolv.conf
sudo chroot ./debian-sid sed -i 's/^# \(en_US.UTF-8\)/\1/' /etc/locale.gen
sudo chroot ./debian-sid /bin/bash -c 'DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales'
sudo rm -rf ./debian-sid/var/lib/apt/lists/*
sudo rm -rf ./debian-sid/var/tmp*
sudo rm -rf ./debian-sid/tmp*
EOF

sudo cp ./wslconf/oobe.sh ./debian-sid/etc/oobe.sh
sudo chmod 644 ./debian-sid/etc/oobe.sh
sudo chmod +x ./debian-sid/etc/oobe.sh
sudo cp ./wslconf/wsl.conf ./debian-sid/etc/wsl.conf
sudo chmod 644 ./debian-sid/etc/wsl.conf
sudo cp ./wslconf/wsl-distribution-sid.conf ./debian-sid/etc/wsl-distribution.conf
sudo chmod 644 ./debian-sid/etc/wsl-distribution.conf
sudo mkdir -p ./debian-sid/usr/lib/wsl/
sudo cp ./wslconf/icon.ico ./debian-sid/usr/lib/wsl/icon.ico

cd ./debian-sid
sudo tar --numeric-owner --absolute-names -c  * | gzip --best > ../install.tar.gz
mv ../install.tar.gz ../debian-sid-$ARCH.wsl