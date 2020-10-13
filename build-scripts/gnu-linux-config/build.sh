#!/bin/sh
set -eux
apk update && apk add g++ gcc make wget ca-certificates file perl linux-headers pkgconf upx ccache 
apk add --no-cache --virtual .build-deps ca-certificates gnutls-dev expat-dev sqlite-dev c-ares-dev cppunit-dev bash-completion openrc xz-libs autoconf automake curl-dev
apk stats
# debian a like
#cd /usr/local/sbin && ln -sfv /usr/lib/ccache/* .
#cd /usr/local/sbin &&  (cd /usr/local/sbin && ln -s /usr/lib/ccache/* . || true )
#cd /usr/local/sbin && ln -sfv /usr/lib/ccache/* . || echo /usr/local/sbin NOT FOUND

# debian a like
cd /usr/lib/ccache/bin && cd /usr/local/sbin && ln -sfv /usr/lib/ccache/bin/* . || echo /usr/lib/ccache/bin/ or /usr/local/sbin NOT FOUND
cd /usr/lib/ccache && cd /usr/local/sbin && ln -sfv /usr/lib/ccache/* . || echo /usr/lib/ccache/ or /usr/local/sbin NOT FOUND
# alpine linux testet on 3.11
cd /usr/lib/ccache/bin && cd /usr/local/bin && ln -sfv /usr/lib/ccache/bin/* . || echo /usr/lib/ccache/bin/ or /usr/local/bin NOT FOUND
cd /usr/lib/ccache && cd /usr/local/bin && ln -sfv /usr/lib/ccache/* . || echo /usr/lib/ccache/ or /usr/local/bin NOT FOUND
#
command -v gcc
which gcc
type gcc
readlink -vvv -f $(command -v gcc) || echo readlink NOT FOUND
realpath $(command -v gcc) || echo realpath NOT FOUND
ls -la $(command -v gcc)

#cd /usr/local/bin && (cd /usr/local/bin && ln -s /usr/lib/ccache/bin/* . || true )
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

echo "strip binary !"
strip src/aria2c
echo "build finished !"
echo "binary file is src/aria2c"

FILEname=src/aria2c
FILEsuffix=upx-9--best--lzma
# FIXME
set +eu
UPXpara="-9 --best --lzma -v --no-progress"
upx $UPXpara -k -o$FILEname-$FILEsuffix $FILEname
upx -t -v $FILEname-$FILEsuffix
upx -l -v $FILEname-$FILEsuffix
upx -d -v -k -o$FILEname-$FILEsuffix-decompress $FILEname-$FILEsuffix
upx $UPXpara -v -k -o$FILEname-$FILEsuffix-decompress-compress $FILEname-$FILEsuffix-decompress
upx -d -v -k -o$FILEname-$FILEsuffix-decompress-compress-decompress $FILEname-$FILEsuffix-decompress-compress
md5sum -b $FILEname*
ls -alhS $FILEname*
set -eu
# FIXME

FILEname=src/aria2c
FILEsuffix=upx-9--best--ultra-brute
# FIXME
set +eu
UPXpara="-9 --best --ultra-brute -v"
upx $UPXpara -k -o$FILEname-$FILEsuffix $FILEname
upx -t -v $FILEname-$FILEsuffix
upx -l -v $FILEname-$FILEsuffix
upx -d -v -k -o$FILEname-$FILEsuffix-decompress $FILEname-$FILEsuffix
upx $UPXpara -v -k -o$FILEname-$FILEsuffix-decompress-compress $FILEname-$FILEsuffix-decompress
upx -d -v -k -o$FILEname-$FILEsuffix-decompress-compress-decompress $FILEname-$FILEsuffix-decompress-compress
md5sum -b $FILEname*
ls -alhS $FILEname*
set -eu
# FIXME
