# Specify the minimum version for CMake
cmake_minimum_required (VERSION 3.0)

# Project's name
project(SSR)
set(CMAKE_VERBOSE_MAKEFILE ON)

# Set the output folder where your program will be created
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/_build)
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/_build)

# Set the compiler
SET(CMAKE_CXX_COMPILER g++)

# The following folder will be included
include_directories(${PROJECT_SOURCE_DIR}/src)

# APF
set(APF_PATH ${PROJECT_SOURCE_DIR}/apf)
include_directories(${APF_PATH})

# Files
# set(HEADER_FILES
# )

set(SOURCE_FILES
    src/ssr_binaural.cpp
    src/audioplayer.cpp
    src/audiorecorder.cpp
    src/configuration.cpp
    src/directionalpoint.cpp
    src/orientation.cpp
    src/position.cpp
    src/scene.cpp
    src/ssr_binaural.cpp
    src/trackerpolhemus.cpp
    src/trackerrazor.cpp
    src/xmlparser.cpp
)

file(GLOB ALL_SOURCES "src/*.cpp")
file(GLOB_RECURSE ALL_HEADERS "src/*.h")

# Libraries
find_package(LibXml2 REQUIRED)
include_directories(${LIBXML2_INCLUDE_DIR})
message(STATUS LIBXML2_FOUND = ${LIBXML2_FOUND})
include_directories(/usr/include/libecasoundc)

# Preprocessor symbols
add_definitions(-DSSR_AUTHORS="ToDo")
add_definitions(-DSSR_DATA_DIR="ToDo")
add_definitions(-DSSR_COPYRIGHT="ToDo")
add_definitions(-DPACKAGE_STRING="ToDo")
add_definitions(-DPACKAGE_URL="ToDo")
add_definitions(-DPACKAGE_BUGREPORT="ToDo")

# Compiler flags
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -std=c++11 -pthread")

#add_executable(ssr-binaural ${SOURCE_FILES} ${HEADER_FILES})
add_executable(ssr-binaural ${SOURCE_FILES})

# Link
#target_link_libraries(ssr-binaural ${LIBXML2_LIBRARIES})
