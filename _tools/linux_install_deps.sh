#!/bin/sh
install=

test -e /etc/os-release && os_release='/etc/os-release' || os_release='/usr/lib/os-release'
if [ -f "$os_release" ]; then
    distrib=$(grep -w ID "$os_release" | cut -d "=" -f 2)
else
    distrib=unknown
fi

if [ "$distrib" = "ubuntu" -o "$distrib" = "linuxmint" -o "$distrib" = "debian" ]; then
    echo "Building on Linux variant ($distrib)"

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
else
    echo "Unsupported Linux variant: $distrib"
    exit 1
fi
