# run: mkdir -p _build && cd _build && cmake .. && make && cd ..
# Specify the minimum version for CMake
cmake_minimum_required (VERSION 3.0)

# Project's name
project(SSR)

# Show more of make
set(CMAKE_VERBOSE_MAKEFILE ON)

# Set the output folder where your program will be created
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/_build)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/src)

# Set the compiler
set(CMAKE_CXX_COMPILER g++)
# Enable C++11
set (CMAKE_CXX_STANDARD 11)

# The following folders will be included
include_directories(${PROJECT_SOURCE_DIR}/src)  # necessary?
set(APF_PATH ${PROJECT_SOURCE_DIR}/apf)
include_directories(${APF_PATH})

# Files
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
    src/ssr_global.cpp
    src/trackerpolhemus.cpp
    src/trackerrazor.cpp
    src/xmlparser.cpp
    src/razor-ahrs/RazorAHRS.cpp
    src/network/commandparser.cpp
    src/network/connection.cpp
    src/network/networksubscriber.cpp
    src/network/server.cpp
)

# Libraries
set(LINKLIBS)

find_package(Threads REQUIRED)

find_package(LibXml2 REQUIRED)
include_directories(${LIBXML2_INCLUDE_DIR})

find_library(LIBSNDFILE_LIBRARY NAMES sndfile)
list(APPEND LINKLIBS ${LIBSNDFILE_LIBRARY})
message(STATUS "Found SNDFILE" : ${LIBSNDFILE_LIBRARY})

find_path(ECASOUND_INCLUDE_DIR NAMES ecasoundc.h HINTS /usr/include/libecasoundc)
include_directories(${ECASOUND_INCLUDE_DIR})
find_library(ECASOUND_LIBRARY NAMES ecasoundc)
list(APPEND LINKLIBS ${ECASOUND_LIBRARY})
message(STATUS "Found ECASOUND" : ${ECASOUND_LIBRARY})

find_library(JACK_LIBRARY NAMES jack)
list(APPEND LINKLIBS ${JACK_LIBRARY})
message(STATUS "Found JACK" : ${JACK_LIBRARY})

find_library(FFTW_LIBRARY NAMES fftw3)
list(APPEND LINKLIBS ${FFTW_LIBRARY})
message(STATUS "Found FFTW" : ${FFTW_LIBRARY})

find_library(FFTWF_LIBRARY NAMES fftw3f)
list(APPEND LINKLIBS ${FFTWF_LIBRARY})
message(STATUS "Found FFTWF" : ${FFTWF_LIBRARY})


# Preprocessor symbols
add_definitions(-DSSR_AUTHORS="TODO")
add_definitions(-DSSR_DATA_DIR="${PROJECT_SOURCE_DIR}/data/")
add_definitions(-DSSR_COPYRIGHT="TODO")
add_definitions(-DPACKAGE_STRING="TODO")
add_definitions(-DPACKAGE_URL="TODO")
add_definitions(-DPACKAGE_BUGREPORT="TODO")
#add_definitions(-DASIO_STANDALONE)  # necessary?

# Compiler flags
set(THREADS_PREFER_PTHREAD_FLAG ON)
set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -g)

# Compile
add_executable(ssr-binaural ${SOURCE_FILES})

# Link
target_link_libraries(ssr-binaural Threads::Threads ${LIBXML2_LIBRARIES})
target_link_libraries(ssr-binaural ${LINKLIBS})
