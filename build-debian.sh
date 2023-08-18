#!/bin/bash
ACSOPATCH_VER=6.3
KERNEL_VER=6.3
sudo apt install build-essential libncurses5-dev fakeroot xz-utils libelf-dev liblz4-tool \
  unzip flex bison bc debhelper rsync libssl-dev:native
wget -N https://raw.githubusercontent.com/benbaker76/linux-acs-override/main/$ACSOPATCH_VER/acso.patch
wget -N https://github.com/torvalds/linux/archive/refs/tags/v$KERNEL_VER.zip
unzip -o v$KERNEL_VER.zip
cd linux-$KERNEL_VER
patch -p1 < ../acso.patch
make menuconfig
sudo make olddefconfig -j $(nproc) bindeb-pkg LOCALVERSION=-acso KDEB_PKGVERSION=$(make kernelversion)-1
