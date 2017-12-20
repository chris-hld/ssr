# run: mkdir -p _build && cd _build && cmake -DCMAKE_BUILD_TYPE=RELEASE .. && make -j3 && cd ..
# Specify the minimum version for CMake
cmake_minimum_required (VERSION 3.0)

# Project's name
project(SSR)

# The version number
set(SSR_VERSION 0.5.0-cmake)

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
include_directories(${PROJECT_SOURCE_DIR}/src)

# Include APF
set(APF_PATH ${PROJECT_SOURCE_DIR}/apf)
include_directories(${APF_PATH})

# Files
set(SOURCE_FILES
    src/configuration.cpp
    src/directionalpoint.cpp
    src/orientation.cpp
    src/position.cpp
    src/scene.cpp
    src/ssr_global.cpp
    src/xmlparser.cpp
)

set(MAIN_SOURCE_FILES
    src/ssr_binaural
    src/ssr_wfs)

# Libraries
# Add libraries to LINKLIBS
set(LINKLIBS)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
find_package(Threads REQUIRED)

find_package(LibXml2 REQUIRED)
include_directories(${LIBXML2_INCLUDE_DIR})
list(APPEND LINKLIBS ${LIBXML2_LIBRARIES})

find_library(LIBSNDFILE_LIBRARY NAMES sndfile)
list(APPEND LINKLIBS ${LIBSNDFILE_LIBRARY})
message(STATUS "Found SNDFILE: " ${LIBSNDFILE_LIBRARY})

option(ENABLE_ECASOUND "Ecasound soundfile playback/recording" ON)
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
endif(ENABLE_ECASOUND)

find_library(JACK_LIBRARY NAMES jack)
list(APPEND LINKLIBS ${JACK_LIBRARY})
message(STATUS "Found JACK :" ${JACK_LIBRARY})

find_library(FFTW_LIBRARY NAMES fftw3)
list(APPEND LINKLIBS ${FFTW_LIBRARY})
message(STATUS "Found FFTW: " ${FFTW_LIBRARY})

find_library(FFTWF_LIBRARY NAMES fftw3f)
list(APPEND LINKLIBS ${FFTWF_LIBRARY})
message(STATUS "Found FFTWF: " ${FFTWF_LIBRARY})

# GUI
option(GUI "Build GUI" ON)
if(GUI)
  # Tell CMake to run moc when necessary:
  set(CMAKE_AUTOMOC ON)
  # As moc files are generated in the binary dir, always look for includes there:
  set(CMAKE_INCLUDE_CURRENT_DIR ON)

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

  # Widgets finds its own dependencies (QtGui and QtCore).
  find_package(Qt5Widgets REQUIRED)
  # The Qt5Widgets_INCLUDES also includes the include directories for
  # dependencies QtCore and QtGui
  include_directories(${Qt5Widgets_INCLUDE_DIRS})
  # We need add -DQT_WIDGETS_LIB when using QtWidgets in Qt 5.
  add_definitions(${Qt5Widgets_DEFINITIONS})

  find_package(Qt5OpenGL REQUIRED)
  find_package(OpenGL REQUIRED)
  include_directories(${OPENGL_INCLUDE_DIR})

  list(APPEND LINKLIBS ${OPENGL_gl_LIBRARY})
  list(APPEND LINKLIBS ${OPENGL_glu_LIBRARY})

  option(ENABLE_GUI "graphical user interface (using Qt)" ON)
  option(ENABLE_FLOATING_CONTROL_PANEL "separate control window" ON)

  message(STATUS "Build GUI")

else()
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
  add_definitions(-DASIO_STANDALONE)  # necessary?
  message(STATUS "Enabled network interface")
endif(ENABLE_IP_INTERFACE)

# Head tracker
option(HEAD_TRACKER "Basic head tracker support" ON)
if(HEAD_TRACKER)
  list(APPEND SOURCE_FILES
    src/trackerpolhemus.cpp
    src/trackerrazor.cpp
    src/razor-ahrs/RazorAHRS.cpp
  )
  set(ENABLE_RAZOR ON)
  set(ENABLE_POLHEMUS ON)
  message(STATUS "Basic head tracker support")
endif(HEAD_TRACKER)

# Preprocessor symbols
add_definitions(-DSSR_DATA_DIR="${PROJECT_SOURCE_DIR}/data")

# Config definitions
# configure a header file to pass some of the CMake settings
# to the source code
add_definitions(-DHAVE_CONFIG_H)
configure_file (
  "${PROJECT_SOURCE_DIR}/generate_config.h.in"
  "${PROJECT_SOURCE_DIR}/src/config.h"
  )

# Compiler flags
set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-g")

# Compile
add_executable(ssr-binaural src/ssr_binaural.cpp ${SOURCE_FILES})
add_executable(ssr-wfs src/ssr_wfs.cpp ${SOURCE_FILES})

# Link
target_link_libraries(ssr-binaural Threads::Threads ${LINKLIBS})
target_link_libraries(ssr-wfs Threads::Threads ${LINKLIBS})
if(GUI)
  target_link_libraries(ssr-binaural Qt5::Widgets Qt5::OpenGL)
  target_link_libraries(ssr-wfs Qt5::Widgets Qt5::OpenGL)
endif(GUI)
