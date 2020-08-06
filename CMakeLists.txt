cmake_minimum_required(VERSION 3.16)
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
project(basic_qml)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 20)

find_package(Qt5 COMPONENTS Quick Widgets REQUIRED)
find_package(Qt5QuickCompiler)
qtquick_compiler_add_resources(RESOURCES qml.qrc)

if (ANDROID)
    include(platforms/Android/AddQtAndroidApk.cmake)

    set(QT_ANDROID_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/platforms/Android CACHE STRING "Source directory of AddQtAndroidApk.cmake")
    set(QT_ANDROID_QT_ROOT ${QT_ANDROID_QT_ROOT} CACHE STRING "Qt SDK root folder")
    set(QT_ANDROID_SDK_ROOT ${QT_ANDROID_SDK_ROOT} CACHE STRING "" FORCE)
    set(QT_ANDROID_NDK_ROOT ${QT_ANDROID_NDK_ROOT} CACHE STRING "" FORCE)

    add_library(basic_qml
            main.cpp
            ${RESOURCES})

    add_qt_android_apk(basic_qml_apk basic_qml
            INSTALL
            )
if (IOS)
    find_package(Qt5Core            CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
    find_package(Qt5Gui             CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
    find_package(Qt5Qml             CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
    find_package(Qt5QmlWorkerScript CONFIG QUIET    NO_CMAKE_SYSTEM_PATH)
    find_package(Qt5Quick           CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
    find_package(Qt5QuickControls2  CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
    find_package(Qt5Svg             CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
    find_package(Qt5Xml             CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)

    add_executable(basicqml
            main.cpp
            qml.qrc)

    INCLUDE(QtIosCMake/AddQtIosApp.cmake)

    target_link_libraries(basicqml PRIVATE
            Qt5::Core
            Qt5::Gui
            Qt5::Svg
            Qt5::Xml
            Qt5::Qml
            Qt5::Quick
            Qt5::QuickControls2
            )

    include(QtStaticCMake/QtStaticCMake.cmake)

    qt_generate_plugin_import(basicqml VERBOSE)

    # EXTRA_PLUGIN are the one required by plugin loaded by qt_generate_plugin_import
    # It's not automatic yet :( All this workflow might change in future version of qt
    # with better and better cmake support
    qt_generate_qml_plugin_import(basicqml
            QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}/
            EXTRA_PLUGIN
            QtQuickVirtualKeyboardPlugin
            QtQuickVirtualKeyboardSettingsPlugin
            QtQuickVirtualKeyboardStylesPlugin
            QmlFolderListModelPlugin
            QQuickLayoutsPlugin
            VERBOSE
            )

    add_qt_ios_app(basicqml
            NAME "Basic QML"
            BUNDLE_IDENTIFIER "com.company.basicqml"
            VERSION "1.2.3"
            SHORT_VERSION "1.2.3"
            LONG_VERSION "1.2.3.456"
            SUPPORT_IPHONE
            REQUIRES_FULL_SCREEN
            VERBOSE
            )
else ()
    add_executable(basic_qml
            main.cpp
            ${RESOURCES})
endif ()

target_link_libraries(basic_qml
        Qt5::Widgets
        Qt5::Quick
        )