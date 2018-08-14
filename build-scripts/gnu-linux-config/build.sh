#!/bin/sh

apk update && apk add g++ gcc make wget ca-certificates file perl

sh /usr/local/src/aria2-static-builds/build-scripts/gnu-linux-config/aria2-x86_64-gnu-linux-build-libs
cd /tmp;
[ ! -f aria2-1.34.0.tar.xz ] && wget https://github.com/aria2/aria2/releases/download/release-1.34.0/aria2-1.34.0.tar.xz;
tar xf aria2-1.34.0.tar.xz;
cd aria2-1.34.0;
sh /usr/local/src/aria2-static-builds/build-scripts/gnu-linux-config/aria2-x86_64-gnu-linux-config
make -j`grep -c ^processor /proc/cpuinfo`
strip src/aria2c
echo "build finished !"
echo "binary file is src/aria2c"
