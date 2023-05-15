set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# PNG
find_package(ZLIB REQUIRED)
find_package(PNG REQUIRED)

# the source files
file(GLOB SOURCE_FILES
        "*.h"
        "*.cpp"
        )

# Find Qt. Use a CMake definition to point it to your Qt installation
# location (if necessary), e.g: -DCMAKE_PREFIX_PATH=/home/user/Qt/5.15.2/gcc_64
find_package(Qt5 REQUIRED COMPONENTS Core Widgets Gui Network Svg Xml Quick Qml QuickControls2 QmlImportScanner)

qt5_add_resources(RESOURCES assets.qrc)

set(EXECUTABLE_FLAG)

# Mac OS bundle
if(APPLE)
    set(ICON ${PROJECT_SOURCE_DIR}/src/assets/appicons/appicon.icns)
    set_source_files_properties(${ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
    list(APPEND RESOURCES ${ICON})
endif()

add_executable(qml_hello ${EXECUTABLE_FLAG} main.cpp
        ${SOURCE_FILES}
        ${RESOURCES}
        )

# Mac OS bundle
if(APPLE)
    set_target_properties(qml_hello PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
            MACOSX_BUNDLE TRUE
            MACOSX_BUNDLE_INFO_PLIST "${CMAKE_SOURCE_DIR}/utils/Info.plist"
            LINK_FLAGS_RELEASE -s
            )
endif()

set_property(TARGET qml_hello PROPERTY RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

target_include_directories(qml_hello PUBLIC ${Qt5Gui_PRIVATE_INCLUDE_DIRS})

target_include_directories(qml_hello PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${X11_INCLUDE_DIR}
        ${OPENSSL_INCLUDE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${Qt5Core_INCLUDE_DIRS}
        ${Qt5Widgets_INCLUDE_DIRS}
        ${Qt5Gui_INCLUDE_DIRS}
        ${Qt5Network_INCLUDE_DIRS}
        ${Qt5Svg_INCLUDE_DIRS}
        ${Qt5Xml_INCLUDE_DIRS}
        ${Qt5WebSockets_INCLUDE_DIRS}
        )

add_definitions(${QT_DEFINITIONS})
if(NOT "${CMAKE_BUILD_TYPE}" EQUAL "Debug")
    add_definitions(-DQT_NO_DEBUG)
endif()

qt5_import_qml_plugins(${PROJECT_NAME})

target_compile_definitions(qml_hello
        PUBLIC
        ${Qt5Core_DEFINITIONS}
        ${Qt5Widgets_DEFINITIONS}
        ${Qt5Gui_DEFINITIONS}
        ${Qt5Network_DEFINITIONS}
        ${Qt5Svg_DEFINITIONS}
        ${Qt5Xml_DEFINITIONS}
        ${Qt5WebSockets_DEFINITIONS}
        )

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")

target_link_libraries(qml_hello PUBLIC
        ${OPENSSL_LIBRARIES}
        ${CMAKE_DL_LIBS}
        Qt5::Core
        Qt5::Widgets
        Qt5::Gui
        Qt5::Network
        Qt5::Svg
        Qt5::QSvgPlugin
        Qt5::QSvgIconPlugin
        Qt5::Xml
        Qt5::Quick
        Qt5::Qml
        Qt5::QuickControls2
        Threads::Threads
)

if(NOT APPLE)
    target_link_libraries(qml_hello PUBLIC
            Qt5::QSvgIconPlugin
            Qt5::QSvgPlugin
            )
endif()

if(STATIC)
    target_link_libraries(qml_hello PUBLIC
            Qt5::QSvgIconPlugin
            Qt5::QSvgPlugin)
    if(UNIX AND NOT APPLE)
        target_link_libraries(qml_hello PUBLIC
                Qt5::QXcbIntegrationPlugin)
    endif()
endif()

if(X11_FOUND)
    target_link_libraries(qml_hello PUBLIC ${X11_LIBRARIES})
endif()

if(APPLE)
    include(Deploy)
endif()

install(TARGETS qml_hello
        DESTINATION ${CMAKE_INSTALL_PREFIX}
        )
