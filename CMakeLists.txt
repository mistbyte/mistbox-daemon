# CMake file based on http://elementaryos.org/docs/developer-guide/cmake/simple-project


cmake_minimum_required (VERSION 2.8)
cmake_policy(VERSION 2.8)

project(mistbox)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )

add_subdirectory (src)
add_subdirectory (schemas)
