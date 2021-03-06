# run e.g.: mkdir -p _build && cd _build && cmake -DCMAKE_BUILD_TYPE=RELEASE .. && make -j3 && cd ..
# Specify the minimum version for CMake
message(STATUS "CMAKE_VERSION: " ${CMAKE_VERSION})
cmake_minimum_required(VERSION 3.8)

# Project's name
project(SSR)

# The version number
set(SSR_VERSION 0.5.1-cmake)

# Show more of make
set(CMAKE_VERBOSE_MAKEFILE ON)

# Set the output folder where your program will be created
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/_build)
if(WIN32)
  set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
else(WIN32)
  set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/src)
endif(WIN32)

# Show the compiler
message(STATUS "Comiler: " ${CMAKE_CXX_COMPILER})
message(STATUS "Compiler ID: " ${CMAKE_CXX_COMPILER_ID})

# Enable C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# The following folders will be included
include_directories(${PROJECT_SOURCE_DIR}/src)

# Include APF
set(APF_PATH ${PROJECT_SOURCE_DIR}/apf)
include_directories(${APF_PATH})

# Include GML
set(GML_PATH ${PROJECT_SOURCE_DIR}/gml/include)
include_directories(${GML_PATH})

# Files
set(SOURCE_FILES
    src/configuration.cpp
    src/ssr_global.cpp
    src/xmlparser.cpp
    src/legacy_directionalpoint.cpp
    src/legacy_orientation.cpp
    src/legacy_position.cpp
    src/legacy_scene.cpp
    )

# Libraries
# Add libraries to LINKLIBS
set(LINKLIBS)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
find_package(Threads REQUIRED)

# TODO
find_package(PkgConfig REQUIRED)

if(WIN32)
  # Set Path to extern headers and libraries for Windows builds
  set(EXTERN_PATH ${PROJECT_SOURCE_DIR}/extern)
  set(CMAKE_PREFIX_PATH ${EXTERN_PATH})
  message(STATUS "WINDOWS Prefix: " ${CMAKE_PREFIX_PATH})

  # Include extern headers
  include_directories(${EXTERN_PATH}/include)
  message(STATUS "WINDOWS Included: " ${EXTERN_PATH}/include)

  # here is the target environment located
  set (USER_ROOT_PATH ${PROJECT_SOURCE_DIR}/extern)
  set (CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} ${EXTERN_PATH})
endif(WIN32)

if(WIN32)
  # Use custom static libxml2 build for MSVC
  if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    find_library(XML2_LIBRARY NAMES libxml2_msvc)
  else()
    find_library(XML2_LIBRARY NAMES libxml2)
  endif()
  include_directories(${LIBXML2_INCLUDE_DIR})
  list(APPEND LINKLIBS ${XML2_LIBRARY})
  add_definitions(-DLIBXML_STATIC)
  #list(APPEND LINKLIBS "-lxml2 -lz -llzma -lws2_32")
  list(APPEND LINKLIBS "-llzma")
  message(STATUS "Found XML2: " ${XML2_LIBRARY})
else(WIN32)
  find_package(LibXml2 REQUIRED)
  include_directories(${LIBXML2_INCLUDE_DIR})
  list(APPEND LINKLIBS ${LIBXML2_LIBRARY})
endif(WIN32)

find_library(LIBSNDFILE_LIBRARY NAMES sndfile libsndfile-1)
list(APPEND LINKLIBS ${LIBSNDFILE_LIBRARY})
list(APPEND LINKLIBS -lFLAC -lvorbisenc -lvorbis -logg)
message(STATUS "Found SNDFILE: " ${LIBSNDFILE_LIBRARY})

option(ENABLE_ECASOUND "Ecasound soundfile playback/recording" OFF)
if(ENABLE_ECASOUND)
  list(APPEND SOURCE_FILES
    src/audioplayer.cpp
    src/audiorecorder.cpp
    )
  find_path(ECASOUND_INCLUDE_DIR NAMES ecasoundc.h HINTS /usr/include/libecasoundc)
  include_directories(${ECASOUND_INCLUDE_DIR})
  find_library(ECASOUND_LIBRARY NAMES ecasoundc)
  list(APPEND LINKLIBS ${ECASOUND_LIBRARY})
  message(STATUS "Found ECASOUND: " ${ECASOUND_LIBRARY})
else(ENABLE_ECASOUND)
  message(WARNING "ECASOUND disabled.")
endif(ENABLE_ECASOUND)

find_library(JACK_LIBRARY NAMES jack libjack64)
list(APPEND LINKLIBS ${JACK_LIBRARY})
message(STATUS "Found JACK :" ${JACK_LIBRARY})

if(WIN32)
  find_library(JACKSERVER_LIBRARY NAMES libjackserver64)
  list(APPEND LINKLIBS ${JACKSERVER_LIBRARY})
  message(STATUS "Found JACK :" ${JACKSERVER_LIBRARY})
endif(WIN32)

find_library(FFTW_LIBRARY NAMES fftw3 libfftw3-3)
list(APPEND LINKLIBS ${FFTW_LIBRARY})
message(STATUS "Found FFTW: " ${FFTW_LIBRARY})

find_library(FFTWF_LIBRARY NAMES fftw3f libfftw3f-3)
list(APPEND LINKLIBS ${FFTWF_LIBRARY})
message(STATUS "Found FFTWF: " ${FFTWF_LIBRARY})

# GUI
option(GUI "Build GUI" ON)
if(GUI)
  # Find includes in corresponding build directories
  set(CMAKE_INCLUDE_CURRENT_DIR ON)
  # Turn on automatic invocation of the MOC
  set(CMAKE_AUTOMOC ON)

  include_directories(${PROJECT_SOURCE_DIR}/src/gui)  # necessary?
  set(GUI_SOURCE_FILES
      src/gui/qclicktextlabel.cpp
      src/gui/qcpulabel.cpp
      src/gui/qfilemenulabel.cpp
      src/gui/qgui.cpp
      src/gui/qguiframe.cpp
      src/gui/qopenglplotter.cpp
      src/gui/qscenebutton.cpp
      src/gui/qsourceproperties.cpp
      src/gui/qssrtimeline.cpp
      src/gui/qtimeedit.cpp
      src/gui/quserinterface.cpp
      src/gui/qvolumeslider.cpp
      src/gui/qzoomlabel.cpp
      )
  list(APPEND SOURCE_FILES ${GUI_SOURCE_FILES})

  option(ENABLE_GUI "graphical user interface (using Qt)" ON)
  option(ENABLE_FLOATING_CONTROL_PANEL "separate control window" ON)
  option(STATIC_QT "Use static Qt5 libraries (Windows)" ON)

  find_package(Qt5 COMPONENTS Core Gui Widgets OpenGL REQUIRED)
  message(STATUS "Found QT5: " ${Qt5_DIR})

  if(WIN32)
    if(STATIC_QT)
      add_definitions(-DQT_STATICPLUGIN)
    endif(STATIC_QT)

    # Platform support libs for Windows
    set(QT5PLATFORMSUPPORT_LIBS
        Qt5::QWindowsIntegrationPlugin
        )

    # Qt5PlatformSupport modules
    find_library(Qt5ThemeSupport_LIBRARY Qt5ThemeSupport)
    list(APPEND QT5PLATFORMSUPPORT_LIBS ${Qt5ThemeSupport_LIBRARY})
    find_library(Qt5FontDatabaseSupport_LIBRARY Qt5FontDatabaseSupport)
    list(APPEND QT5PLATFORMSUPPORT_LIBS ${Qt5FontDatabaseSupport_LIBRARY})
    find_library(Qt5EventDispatcherSupport_LIBRARY Qt5EventDispatcherSupport)
    list(APPEND QT5PLATFORMSUPPORT_LIBS ${Qt5EventDispatcherSupport_LIBRARY})
    find_library(Qt5AccessibilitySupport_LIBRARY Qt5AccessibilitySupport)
    list(APPEND QT5PLATFORMSUPPORT_LIBS ${Qt5AccessibilitySupport_LIBRARY})
    find_library(Qt5WindowsUIAutomationSupport_LIBRARY Qt5WindowsUIAutomationSupport)
    list(APPEND QT5PLATFORMSUPPORT_LIBS ${Qt5WindowsUIAutomationSupport_LIBRARY})
    find_package(Freetype REQUIRED)
    list(APPEND QT5PLATFORMSUPPORT_LIBS ${FREETYPE_LIBRARIES})

    message(STATUS "Found Qt5PlatformSupport: " ${QT5PLATFORMSUPPORT_LIBS})
  endif(WIN32)

  # OpenGL
  find_package(OpenGL REQUIRED)
  include_directories(${OPENGL_INCLUDE_DIR})
  list(APPEND LINKLIBS ${OPENGL_gl_LIBRARY})
  list(APPEND LINKLIBS ${OPENGL_glu_LIBRARY})

  message(STATUS "Build GUI")

else(GUI)
  message(WARNING "GUI disabled. Switch on with 'cmake .. -DGUI=ON'")
endif(GUI)

# Network
option(ENABLE_IP_INTERFACE "network (TCP/IP) interface" ON)
if(ENABLE_IP_INTERFACE)
  list(APPEND SOURCE_FILES
    src/network/commandparser.cpp
    src/network/connection.cpp
    src/network/networksubscriber.cpp
    src/network/server.cpp
    )
  include_directories(${PROJECT_SOURCE_DIR}/src/network)
  add_definitions(-DASIO_STANDALONE)
  if(WIN32)
    add_definitions(-D_WIN32_WINNT=0x0601)  # Windows 7
    list(APPEND LINKLIBS "-lws2_32 -lmswsock")
  endif(WIN32)
  message(STATUS "Enabled network interface")

else(ENABLE_IP_INTERFACE)
  message(WARNING "IP_INTERFACE disabled.")
endif(ENABLE_IP_INTERFACE)

# Head tracker
option(HEAD_TRACKER "Basic head tracker support" ON)
if(HEAD_TRACKER)
  list(APPEND SOURCE_FILES
    src/trackerrazor.cpp
    src/razor-ahrs/RazorAHRS.cpp
    src/trackerpolhemus.cpp
    )
  set(ENABLE_RAZOR ON)
  set(ENABLE_POLHEMUS ON)
  if(WIN32)
    add_definitions(-DENABLE_O_NDELAY_WORKAROUND)  # bits/fcntl2.h
  endif(WIN32)
  message(STATUS "Basic head tracker support")
else(HEAD_TRACKER)
  message(WARNING "HEAD_TRACKER disabled.")
endif(HEAD_TRACKER)


# Preprocessor symbols
add_definitions(-DSSR_DATA_DIR="./data")

# Config definitions
# configure a header file to pass some of the CMake settings
# to the source code
add_definitions(-DHAVE_CONFIG_H)
configure_file(
  "${PROJECT_SOURCE_DIR}/generate_config.h.in"
  "${PROJECT_SOURCE_DIR}/src/config.h"
  )


# Compiler flags
# Add a few for release builds (MAKE_BUILD_TYPE=RELEASE)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -pipe -Wall -fomit-frame-pointer -ffast-math -funroll-loops -march=x86-64 -mmmx -msse -msse2 -mfpmath=sse")
message(STATUS "Release Flags: " ${CMAKE_CXX_FLAGS_RELEASE})
# And for debug builds (MAKE_BUILD_TYPE=DEBUG)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -pipe -Wall -ffast-math -march=x86-64 -mmmx -msse -msse2 -mfpmath=sse -Weffc++")
message(STATUS "Debug Flags: " ${CMAKE_CXX_FLAGS_DEBUG})

# Compile executables
set(EXECUTABLES
    ssr-binaural
    ssr-brs
    ssr-vbap
    ssr-wfs
    ssr-aap
    ssr-dca
    ssr-generic
    )
add_executable(ssr-binaural src/ssr_binaural.cpp ${SOURCE_FILES})
add_executable(ssr-brs src/ssr_brs.cpp ${SOURCE_FILES})
add_executable(ssr-vbap src/ssr_vbap.cpp ${SOURCE_FILES})
add_executable(ssr-wfs src/ssr_wfs.cpp ${SOURCE_FILES})
add_executable(ssr-aap src/ssr_aap.cpp ${SOURCE_FILES})
add_executable(ssr-dca src/ssr_dca.cpp ${SOURCE_FILES})
add_executable(ssr-generic src/ssr_generic.cpp ${SOURCE_FILES})


# Link
if(WIN32)
  set(CMAKE_EXE_LINKER_FLAGS "-static -static-libgcc -static-libstdc++")
endif(WIN32)

message(STATUS "Linking: "  ${LINKLIBS} ${QT5PLATFORMSUPPORT_LIBS})

foreach(executable ${EXECUTABLES})
  target_link_libraries(${executable} Threads::Threads)
  target_link_libraries(${executable} ${LINKLIBS})
  if(GUI)
    target_link_libraries(${executable} Qt5::Gui Qt5::Core Qt5::Widgets Qt5::OpenGL ${QT5PLATFORMSUPPORT_LIBS})
  endif(GUI)
endforeach(executable ${EXECUTABLES})
