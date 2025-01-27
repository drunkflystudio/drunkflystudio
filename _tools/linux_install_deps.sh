#!/bin/sh
install=

dpkg -l | grep gcc-multilib >/dev/null 2>&1
if [ "$?" != 0 ]; then
    install="$install gcc-multilib"
fi

dpkg -l | grep g++-multilib >/dev/null 2>&1
if [ "$?" != 0 ]; then
    install="$install g++-multilib"
fi

which cmake >/dev/null 2>&1
if [ "$?" != 0 ]; then
    install="$install cmake"
fi

which ninja >/dev/null 2>&1
if [ "$?" != 0 ]; then
    install="$install ninja-build"
fi

if [ "$install" != "" ]; then
    echo Need to install the following packages: $install
    sudo apt-get install $install
fi
