rm -r _build
mkdir -p _build && cd _build

export PATH=/home/chris/git/mxe/usr/bin:$PATH
#cmake -DCMAKE_TOOLCHAIN_FILE=../Toolchain-mingw64.cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
x86_64-w64-mingw32.static.posix-cmake ... -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..

make -j8
cd ..
