# Install script for directory: /root/Tars/cpp/framework

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local/tars/cpp")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "0")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/root/Tars/cpp/build/framework/protocol/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/ConfigServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/NodeServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/NotifyServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/PatchServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/AdminRegistryServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/RegistryServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/PropertyServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/LogServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/patchclient/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/StatServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/QueryStatServer/cmake_install.cmake")
  INCLUDE("/root/Tars/cpp/build/framework/QueryPropertyServer/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

