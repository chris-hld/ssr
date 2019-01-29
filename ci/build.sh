#!/bin/bash
set -xeu

if [ "$TRAVIS_OS_NAME" == "linux" ]
then
    if [ "${TARGET}" = "windows64" ]
    then
        PATH=$PATH:/usr/lib/mxe/usr/bin
        cd ..
        rm -r _build
        mkdir -p _build && cd _build
        x86_64-w64-mingw32.static-cmake ... -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
        make
        cd ..
    else
      ./configure --prefix='/usr'
      make && sudo make install
    fi
fi

if [ "$TRAVIS_OS_NAME" == "osx" ]
then
    ./configure
    make
fi

exit 0
