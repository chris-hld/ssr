#!/bin/bash
set -xeu


if [ "${TARGET}" = "windows32" ] || [ "${TARGET}" = "windows64" ]
then
    # Add debian packages built from MXE packages
    echo "deb http://pkg.mxe.cc/repos/apt/debian jessie main" | sudo tee --append /etc/apt/sources.list.d/mxeapt.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB

    if [ "${TARGET}" = "windows64" ]
    then
        PKG_PREFIX="mxe-x86-64-w64-mingw32.static"
    else
        PKG_PREFIX="mxe-i686-w64-mingw32.shared"
    fi

    sudo apt-get update
	# cc cmake pthreads fftw libsndfile libxml2 qtbase
    sudo apt-get install ${PKG_PREFIX}-cc \
                         ${PKG_PREFIX}-cmake \
                         ${PKG_PREFIX}-pthreads \
                         ${PKG_PREFIX}-fftw \
                         ${PKG_PREFIX}-libsndfile \
                         ${PKG_PREFIX}-libxml2 \
                         ${PKG_PREFIX}-qtbase
fi

PATH=$PATH:/usr/lib/mxe/usr/bin

exit 0
