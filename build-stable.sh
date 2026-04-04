# export the env
export RELEASE=trixie
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
echo "RELEASE=$RELEASE" >> "$GITHUB_ENV"
echo "ARCH=$ARCH" >> "$GITHUB_ENV"

# install depedencies
sudo apt update && sudo apt install -yq curl libarchive-tools
curl -L -o /tmp/mmdebstrap.deb http://ftp.us.debian.org/debian/pool/main/m/mmdebstrap/mmdebstrap_1.5.7-3_all.deb
sudo apt install -yq /tmp/mmdebstrap.deb
curl -L -o /tmp/keyring.deb http://ftp.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2025.1_all.deb
sudo apt install -yq /tmp/keyring.deb

# start build with mmdebstrap
dist_version="$RELEASE"
sudo mmdebstrap \
    --arch=amd64 \
    --variant=minbase \
    --components="main,contrib,non-free" \
    --include=ca-certificates,locales \
    --format=tar \
    --customize-hook="chroot \$1 sed -i 's/^# \(en_US.UTF-8\)/\1/' /etc/locale.gen" \
    --customize-hook="chroot \$1 /bin/bash -c 'DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales'" \
    ${dist_version} \
    rootfs.tar.gz

# combine wsldl and rootfs (with matching arch as machine)
cd ../
if [ $ARCH = amd64 ]; then 
    curl -L https://github.com/yuk7/wsldl/releases/download/26032000/icons.zip -o icons.zip
    bsdtar -xf icons.zip
    mv Debian.exe debian.exe
    bsdtar -a -cf debian.zip rootfs.tar.gz debian.exe
else
    curl -L https://github.com/yuk7/wsldl/releases/download/26032000/icons.zip -o icons.zip
    bsdtar -xf icons.zip
    mv Debian.exe debian.exe
    bsdtar -a -cf debian.zip rootfs.tar.gz debian.exe
fi