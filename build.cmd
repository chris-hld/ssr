rmdir /s /q _build
mkdir _build
cd _build
cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
mingw32-make -j8
cd ..