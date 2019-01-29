#!/bin/bash
set -xeu

PATH=$PATH:/usr/lib/mxe/usr/bin

cd ..
rm -r _build
mkdir -p _build && cd _build

x86_64-w64-mingw32.static-cmake ... -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..

cd ..

exit 0
