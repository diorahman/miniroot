#!/bin/bash
TOP=`dirname $0`
pushd $TOP

. settings
rm -rf build/
mkdir -p tmp build

pushd tmp
for i in `cat ../packages|grep -v ^/`;do
  P=$i
  P+=_
  wget -c $REPO/$P$ARCH.deb;
done
for i in `ls -1 *.deb`;do
  dpkg -x $i rootdir
done

for i in `cat ../packages|grep ^/`;do
  D=`dirname $i`
  mkdir -p ../build$D
  cp -a rootdir$i ../build/$D
done

popd

cp -a miniroot/* build/
popd

