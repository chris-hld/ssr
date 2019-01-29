#!/bin/bash
set -xeu


if [ "${TARGET}" = "windows32" ] || [ "${TARGET}" = "windows64" ]
then
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 86B72ED9
	#sudo add-apt-repository 'deb [arch=amd64] http://mirror.mxe.cc/repos/apt trusty main'
	# or https for xenial
	sudo add-apt-repository 'deb [arch=amd64] https://mirror.mxe.cc/repos/apt xenial main'
	sudo apt-get -qq update

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

exit 0
