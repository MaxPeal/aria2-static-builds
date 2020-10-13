#!/bin/sh
set -eu
apk update && apk add g++ gcc make wget ca-certificates file perl linux-headers pkgconf upx ccache 
apk add --no-cache --virtual .build-deps ca-certificates gnutls-dev expat-dev sqlite-dev c-ares-dev cppunit-dev bash-completion openrc xz-libs autoconf automake curl-dev
apk stats
# debian a like
cd /usr/local/sbin &&  ln -s /usr/lib/ccache/* .
# alpine linux testet on 3.11
cd /usr/local/bin && ln -s /usr/lib/ccache/bin/* .
#/tmp/ccache
#ccache -M 2G
ccache -p || ccache --print-config
ccache -s || ccache --show-stats
ccache --print-stats
sh /usr/local/src/aria2-static-builds/build-scripts/gnu-linux-config/aria2-x86_64-gnu-linux-build-libs
cd /tmp;
[ ! -f aria2-1.35.0.tar.xz ] && wget https://github.com/aria2/aria2/releases/download/release-1.35.0/aria2-1.35.0.tar.xz;
tar xf aria2-1.35.0.tar.xz;
cd aria2-1.35.0;

sh /usr/local/src/aria2-static-builds/build-scripts/gnu-linux-config/aria2-x86_64-gnu-linux-config
make -j`grep -c ^processor /proc/cpuinfo`

ccache -s || ccache --show-stats
ccache --print-stats

FILEname=src/aria2c
FILEsuffix=upx-9--best--lzma
UPXpara="-9 --best --lzma -v --no-progress"
upx $UPXpara -k -o$FILEname-$FILEsuffix $FILEname
upx -t -v $FILEname-$FILEsuffix
upx -l -v $FILEname-$FILEsuffix
upx -d -v -k -o$FILEname-$FILEsuffix-decompress $FILEname-$FILEsuffix
upx $UPXpara -v -k -o$FILEname-$FILEsuffix-decompress-compress $FILEname-$FILEsuffix-decompress
upx -d -v -k -o$FILEname-$FILEsuffix-decompress-compress-decompress $FILEname-$FILEsuffix-decompress-compress
md5sum -b $FILEname*
ls -alhS src/


FILEname=src/aria2c
FILEsuffix=upx-9--best--ultra-brute
UPXpara="-9 --best --ultra-brute -v"
upx $UPXpara -k -o$FILEname-$FILEsuffix $FILEname
upx -t -v $FILEname-$FILEsuffix
upx -l -v $FILEname-$FILEsuffix
upx -d -v -k -o$FILEname-$FILEsuffix-decompress $FILEname-$FILEsuffix
upx $UPXpara -v -k -o$FILEname-$FILEsuffix-decompress-compress $FILEname-$FILEsuffix-decompress
upx -d -v -k -o$FILEname-$FILEsuffix-decompress-compress-decompress $FILEname-$FILEsuffix-decompress-compress
md5sum -b $FILEname*
ls -alhS src/

strip src/aria2c
echo "build finished !"
echo "binary file is src/aria2c"
