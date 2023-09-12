cmake_minimum_required(VERSION 3.16)
project(qml_hello)
message(STATUS "Initiating compile using CMake ${CMAKE_VERSION}")

option(STATIC "Link libraries statically, requires static Qt")

# add cmake/ directory as cmake module path
list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_SOURCE_DIR}/cmake")

# why not
set(THREADS_PREFER_PTHREAD_FLAG ON)

set(CMAKE_CXX_STANDARD 14)
include(FindCcache)

# Find OpenSSL
if(APPLE AND NOT OPENSSL_ROOT_DIR)
    execute_process(COMMAND brew --prefix openssl OUTPUT_VARIABLE OPENSSL_ROOT_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()
find_package(OpenSSL REQUIRED)
message(STATUS "OpenSSL: Version ${OPENSSL_VERSION}")
message(STATUS "OpenSSL: include dir at ${OPENSSL_INCLUDE_DIR}")
message(STATUS "OpenSSL: libraries at ${OPENSSL_LIBRARIES} ${OPENSSL_SSL_LIBRARIES}")

# Find X11
if(UNIX AND NOT APPLE AND NOT ANDROID)
    if (NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(CMAKE_SKIP_RPATH ON)
    endif()

    find_package(X11 REQUIRED)
    message(STATUS "X11_FOUND = ${X11_FOUND}")
    message(STATUS "X11_INCLUDE_DIR = ${X11_INCLUDE_DIR}")
    message(STATUS "X11_LIBRARIES = ${X11_LIBRARIES}")

    include_directories(${X11_INCLUDE_DIR})
    link_directories(${X11_LIBRARIES})
    if(STATIC)
        find_library(XCB_LIBRARY xcb)
        message(STATUS "Found xcb library: ${XCB_LIBRARY}")
    endif()
endif()

if(MINGW)
    set(Boost_THREADAPI win32)
    set(Boost_USE_STATIC_LIBS ON)
    set(Boost_USE_STATIC_RUNTIME ON)
    find_package(Iconv REQUIRED)

    string(REGEX MATCH "^[^/]:/[^/]*" msys2_install_path "${CMAKE_C_COMPILER}")
    message(STATUS "MSYS location: ${msys2_install_path}")
    set(CMAKE_INCLUDE_PATH "${msys2_install_path}/mingw${ARCH_WIDTH}/include")
    # This is necessary because otherwise CMake will make Boost libraries -lfoo
    # rather than a full path. Unfortunately, this makes the shared libraries get
    # linked due to a bug in CMake which misses putting -static flags around the
    # -lfoo arguments.
    set(DEFLIB ${msys2_install_path}/mingw${ARCH_WIDTH}/lib)
    list(REMOVE_ITEM CMAKE_C_IMPLICIT_LINK_DIRECTORIES ${DEFLIB})
    list(REMOVE_ITEM CMAKE_CXX_IMPLICIT_LINK_DIRECTORIES ${DEFLIB})

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wa,-mbig-obj")
    set(EXTRA_LIBRARIES mswsock;ws2_32;iphlpapi;crypt32;bcrypt)
    if(DEPENDS)
	    set(ICU_LIBRARIES iconv)
    else()
        set(ICU_LIBRARIES icuio icuin icuuc icudt icutu iconv)
    endif()

    add_link_options(-Wl,--dynamicbase)
    add_link_options(-Wl,--nxcompat)
    add_link_options(-Wl,--high-entropy-va)
endif()

if(STATIC)
    add_link_options(-static-libgcc)
    add_link_options(-static-libstdc++)
    if(MINGW)
        add_link_options(-static)
    endif()
endif()

add_link_options(-fno-strict-aliasing)
add_link_options(-fno-strict-aliasing)

# Find pthread
find_package(Threads REQUIRED)

add_subdirectory(src)
