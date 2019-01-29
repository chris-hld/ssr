#!/usr/bin/env bash

set -euo pipefail

if [ "$TRAVIS_OS_NAME" == "osx" ]; then
  brew install --c++11 \
    asio \
    autoconf \
    ecasound \
    fftw \
    jack \
    liblo \
    libsndfile \
    libxml2 \
    qt
  # using brew, it's not possible to install needed perl dependencies for
  # help2man (Locale::gettext), therefore best disabled for now
#    doxygen \
#    help2man \
fi

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
  if [ "${TARGET}" = "windows32" ] || [ "${TARGET}" = "windows64" ]; then
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
  else
    # autotools, automake, make are present in the xenial image
    sudo apt-get install -y \
      libasio-dev \
      qt5-default \
      libecasoundc-dev \
      doxygen \
      ecasound \
      libxml2-dev \
      libfftw3-dev \
      libsndfile1-dev \
      libjack-dev \
      libjack0 \
      help2man \
      jackd1 \
      pkg-config \
      libtool
  fi
  # force qt 5
  export QT_SELECT=qt5
fi

exit 0
