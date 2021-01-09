cmake_minimum_required(VERSION 3.18)
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
project(basic_qml)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)

find_package(Qt5 REQUIRED COMPONENTS Quick Widgets QuickCompiler)

qtquick_compiler_add_resources(RESOURCES qml.qrc)

if (ANDROID)
    include(cmake/QtAndroidCMake/AddQtAndroidApk.cmake)

    set(QT_ANDROID_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake/QtAndroidCMake CACHE STRING "Source directory of AddQtAndroidApk.cmake")
    set(QT_ANDROID_QT_ROOT ${QT_ANDROID_QT_ROOT} CACHE STRING "Qt SDK root folder")
    set(QT_ANDROID_SDK_ROOT ${QT_ANDROID_SDK_ROOT} CACHE STRING "" FORCE)
    set(QT_ANDROID_NDK_ROOT ${QT_ANDROID_NDK_ROOT} CACHE STRING "" FORCE)

    add_library(basic_qml
            main.cpp
            ${RESOURCES})

    target_link_libraries(basic_qml PRIVATE
            Qt5::Widgets
            Qt5::Quick
            )

    add_qt_android_apk(basic_qml_apk basic_qml
            NAME "Basic QML"
            VERSION_CODE 2
            PACKAGE_NAME "com.mindpower.basic_qml"
            PACKAGE_SOURCES  ${CMAKE_CURRENT_SOURCE_DIR}/platforms/android
            INSTALL
            )
elseif (IOS)
    add_executable(basicqml
            main.cpp
            qml.qrc)

    include(cmake/QtIosCMake/AddQtIosApp.cmake)

    target_link_libraries(basicqml PRIVATE
            Qt5::Widgets
            Qt5::Quick
            )

    include(cmake/QtStaticCMake/QtStaticCMake.cmake)

    qt_generate_plugin_import(basicqml)

    qt_generate_qml_plugin_import(basicqml
            QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}/
            EXTRA_PLUGIN
            QtQuickVirtualKeyboardPlugin
            QtQuickVirtualKeyboardSettingsPlugin
            QtQuickVirtualKeyboardStylesPlugin
            QmlFolderListModelPlugin
            QQuickLayoutsPlugin
            )

    add_qt_ios_app(basicqml
            NAME "Basic QML"
            BUNDLE_IDENTIFIER "com.company.basicqml"
            VERSION "1.2.3"
            SHORT_VERSION "1.2.3"
            LONG_VERSION "1.2.3.456"
            SUPPORT_IPHONE
            REQUIRES_FULL_SCREEN
            )
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Emscripten")
    add_executable(basic_qml
            main.cpp
            ${RESOURCES})

    target_link_libraries(basic_qml PRIVATE
            Qt5::Core
            Qt5::Gui
            Qt5::Svg
            Qt5::Xml
            Qt5::Qml
            Qt5::Quick
            Qt5::QuickControls2
            )

    include(cmake/QtStaticCMake/QtStaticCMake.cmake)

    qt_generate_plugin_import(basic_qml VERBOSE)

    qt_generate_qml_plugin_import(basic_qml
            QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}/
            EXTRA_PLUGIN
            QmlFolderListModelPlugin
            QQuickLayoutsPlugin
            )

    include(cmake/QtWasmCMake/CMakeLists.txt)

    add_qt_wasm_app(basic_qml)
else ()
    add_executable(basic_qml
            main.cpp
            ${RESOURCES})

    target_link_libraries(basic_qml PRIVATE
            Qt5::Widgets
            Qt5::Quick
            )
endif ()

