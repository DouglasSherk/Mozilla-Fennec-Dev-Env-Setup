#!/bin/bash -e

INTERACTIVE=true
if [ "$1" != "--interactive" ]; then
  INTERACTIVE=false
fi

function pause() {
  if [ $INTERACTIVE == true ]; then
    read -p "Press enter to continue..."
  fi
}

USER=$(whoami)

echo "
Welcome to the Ubuntu 12.04 64-bit Fennec dev env setup script. This will
do everything you need to start working on Fennec. If you want to install
interactively, cancel this script now (Ctrl-C) then re-run it with the option
'--interactive'. The first steps take a very very long time, so please be
patient. Depending on your computer and whether or not you're using a VM, this
could literally take an entire day.

This script is only designed to run a completely fresh install of Ubuntu. It
will install ALL prerequisites. It will probably work on an already heavily
used OS depending on how customized it is.

A copy of mozilla-central will be cloned into ~/mozilla-central-mobile/ and be
mostly configured for you.

IMPORTANT: You must have already rooted your device, and it must be plugged in
when you move onto the next step. No other setup is required.
"

cd ~

#read -p "Press enter to continue..."

# Do this early so we can get everything that needs sudo out of the way
# and go unguided later
echo "Setting up USB debugging (make sure your device is plugged in)"
pause
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0502", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0b05", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="413c", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0489", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="04c5", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="091e", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="109b", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="24e3", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="2116", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0482", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="17ef", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="1004", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="22b8", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0409", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="2080", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0955", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="2257", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="10a9", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="1d4d", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0471", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="04da", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="1f53", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="04dd", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="054c", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0fce", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="2340", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0930", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="19d2", MODE="0666", GROUP="plugdev"' | sudo tee /etc/udev/rules.d/51-android.rules

if [ 0 == 1 ]
then
echo "Installing prerequisites, using apt-get"
pause
sudo apt-get -y update
# Android SDK and other prereqs
sudo apt-get -y install openjdk-7-jdk mercurial ccache wget
sudo apt-get -y build-dep firefox
# Eclipse and Eclipse Java plugin
sudo apt-get -y install eclipse eclipse-jdt
# Libs for running 32-bit binaries
sudo apt-get -y install ia32-libs
# Moz-GDB prereqs
sudo apt-get install -y bison flex libncurses5-dev texinfo python2.7-dev git
echo "Installing Android SDK
This will take a very long time. If it asks you to input
a username/password for motorola, just keep hitting enter."
pause
LOTS_OF_RETURN="\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
wget http://dl.google.com/android/ndk/android-ndk-r5c-linux-x86.tar.bz2
tar -xjf android-ndk-r5c-linux-x86.tar.bz2
wget http://dl.google.com/android/android-sdk_r15-linux.tgz
tar -xzf android-sdk_r15-linux.tgz
# go get lunch, this will take a while
echo LOTS_OF_RETURN | ./android-sdk-linux/tools/android update sdk -u
echo LOTS_OF_RETURN | ./android-sdk-linux/tools/android update adb
echo "Cleaning up sdk files"
rm android-ndk-r5c-linux-x86.tar.bz2
rm android-sdk_r15-linux.tgz
fi # if [false]

export PATH=$PATH:$HOME/android-sdk-linux/platform-tools:$HOME/android-sdk-linux/tools

#echo "Increasing linking speed by using gold"
#pause
#sudo apt-get install bison flex
#mkdir ~/gold; pushd ~/gold
#wget http://ftp.gnu.org/gnu/binutils/binutils-2.22.tar.bz2
#tar xfj binutils-2.22.tar.bz2
#mkdir binutils-build; pushd binutils-build
#../binutils-2.22/configure --target=arm-linux-androideabi --prefix=$HOME/gold/arm-linux-androideabi --enable-gold --disable-werror
#make
#make install
#popd

echo "Cloning new repo into ~/mozilla-central-mobile"
pause
cd ~
hg clone http://hg.mozilla.org/mozilla-central mozilla-central-mobile
echo "ac_add_options --with-android-ndk=\"$HOME/android-ndk-r5c\"
ac_add_options --with-android-sdk=\"$HOME/android-sdk-linux/platforms/android-13\"
ac_add_options --with-android-version=5

ac_add_options --enable-application=mobile/android
ac_add_options --target=arm-linux-androideabi
ac_add_options --with-ccache
ac_add_options --enable-tests

mk_add_options MOZ_OBJDIR=./objdir-droid
mk_add_options MOZ_MAKE_FLAGS=\"-j9 -s\"" > mozilla-central-mobile/.mozconfig


echo "Installing JimDB (the current best way to debug C++ on Android)"
pause
cd ~
##### build gdb
# install prereqs
# clone repo
git clone git://github.com/darchons/android-gdb.git
(cd android-gdb && git checkout android-gdb_7_3)
# configure and make
mkdir android-gdb-objdir
cd android-gdb-objdir
export prefix=/nonexistent
../android-gdb/configure --target=arm-elf-linux --with-python=yes --prefix=$prefix \
  --with-gdb-datadir=$prefix/utils --with-system-gdbinit=$prefix/utils/gdbinit
make -j4
##### build gdbserver
# build toolchain
cd ~/android-ndk-r5c
./build/tools/make-standalone-toolchain.sh
mkdir ~/android-toolchain
cd ~/android-toolchain
tar -xvf /tmp/ndk-$USER/arm-linux-androideabi-4.4.3.tar.bz2
export PATH=~/android-toolchain/arm-linux-androideabi-4.4.3/bin:$PATH
# configure and make gdbserver
cd ~
mkdir android-gdbserver-objdir
cd android-gdbserver-objdir
../android-gdb/gdb/gdbserver/configure --host=arm-linux-androideabi \
  --with-sysroot=/home/$USER/android-ndk-r5c/platforms/android-9/arch-arm
make -j4
# create local moz-gdb
cd ~
mkdir -p moz-gdb/bin
cp android-gdb-objdir/gdb/gdb moz-gdb/bin
cp android-gdbserver-objdir/gdbserver moz-gdb/bin
git clone git://github.com/darchons/android-gdbutils.git moz-gdb/utils
# fix gdbinit
sed "s/#python feninit\.default\.objdir.*/python feninit\.default\.objdir = '\/home\/$USER\/mozilla-central-mobile\/objdir-droid'/" moz-gdb/utils/gdbinit > moz-gdb/utils/gdbinit
sed "s/#python feninit\.default\.srcroot.*/python feninit\.default\.srcroot = '\/home\/$USER\/mozilla-central-mobile'/" moz-gdb/utils/gdbinit > moz-gdb/utils/gdbinit

echo "Installing helper scripts for building and debugging to ~/bin"
pause
cp -r bin ~/

echo "Pushing GDB server to device (you have to have rooted it or this will fail)"
pause
adb shell 'su -c "mount -o remount, -rw /dev/block/stl9 /data; chmod 777 /data/local"'
adb push ~/android-gdbserver-objdir/gdbserver /data/local

echo "Building mozilla-central (located in ~/mozilla-central-mobile)"
pause
cd ~/mozilla-central-mobile
make -f client.mk build_and_deploy

echo "You are now ready to use your Fennec dev env. Suggested next steps: add
the following your \$PATH:

export PATH=\$PATH:\$HOME/android-sdk-linux/platform-tools:\$HOME/android-sdk-linux/tools
export PATH=\$PATH:~/bin

If you use these paths, you can build Fennec using:
  fennec_build

You can also debug using:
  fennec_debug
  fennec_debug_java

If you need to do Java debugging, extra setup is required. Running
fennec_debug_java will guide you through this process."
