# CMake file based on http://elementaryos.org/docs/developer-guide/cmake/simple-project

find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.14.0" MINIMUM)
include(ValaPrecompile)


find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gio-2.0)
set(CFLAGS ${DEPS_CFLAGS}
    ${DEPS_CFLAGS_OTHER} )
set(LIB_PATHS ${DEPS_LIBRARY_DIRS} )
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS})

vala_precompile(VALA_C 
    Main.vala
PACKAGES
    gio-2.0
OPTIONS
    --thread)


add_executable (mistboxd ${VALA_C})
target_link_libraries(mistboxd ${DEPS_LIBRARIES})

install(TARGETS mistboxd RUNTIME DESTINATION bin)
