rm -r _build
mkdir -p _build && cd _build
cmake -DCMAKE_TOOLCHAIN_FILE=/home/chris/git/ssr-chris/Toolchain-mingw64.cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
make -j8
cd ..
