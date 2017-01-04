
# We define the minimum cmake. This is standard for elementary OS
cmake_minimum_required (VERSION 2.8)

#We define the minimum policy version
cmake_policy(VERSION 2.8)


#We define out project name.
project(wunderlistux)

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
set (PKGDATADIR "${DATADIR}/wunderlistux")
set (GETTEXT_PACKAGE "wunderlistux")
add_definitions(-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")
set (RELEASE_NAME "Flugas")
set (VERSION "1.1")

configure_file (${CMAKE_SOURCE_DIR}/src/config.vala.cmake ${CMAKE_SOURCE_DIR}/src/config.vala)

#Here we load the modules we downloaded earlier and placed into the ./cmake directory
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )

# Vala
find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.22.1" MINIMUM)
include (ValaPrecompile)

find_package(PkgConfig)
pkg_check_modules(LIBUNITY QUIET unity)

# Packages
if (LIBUNITY_FOUND)
    message(STATUS "Unity support: ON")
    set(EXTRA_PKG_CONFIG
        ${EXTRA_PKG_CONFIG}
        unity
    )

    set(EXTRA_PACKAGES
        ${EXTRA_PACKAGES}
        unity
    )

    set(EXTRA_VALA_OPTIONS
        ${EXTRA_VALA_OPTIONS}
        -D HAVE_LIBUNITY
    )
else ()
    message(STATUS "Unity launcher support: OFF")
endif ()

set(EXTRA_PACKAGES
    ${EXTRA_PACKAGES}
    Dbusmenu-0.4
)

set(TARGET_GLIB 2.32)

pkg_check_modules(DEPS REQUIRED
	gtk+-3.0
  libsoup-2.4
  webkit2gtk-4.0
	${EXTRA_PKG_CONFIG}
)


set(CFLAGS
    ${DEPS_CFLAGS}
    ${DEPS_CFLAGS_OTHER}
    -D_VERSION=\"${VERSION}\"
    -D_INSTALL_PREFIX=\"${CMAKE_INSTALL_PREFIX}\"
    -D_SOURCE_ROOT_DIR=\"${CMAKE_SOURCE_DIR}\"
    -D_GSETTINGS_DIR=\"${CMAKE_BINARY_DIR}/gsettings\"
    -DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\"
    -DLANGUAGE_SUPPORT_DIRECTORY=\"${LANGUAGE_SUPPORT_DIRECTORY}\"
)

set(BIRDIE_PACKAGES
    gtk+-3.0 libsoup-2.4 webkit2gtk-4.0 ${EXTRA_PACKAGES}
)

set(VALAC_OPTIONS
    --vapidir=${CMAKE_SOURCE_DIR}/vapi
    --disable-warnings
    --target-glib=${TARGET_GLIB}
    --thread
    --enable-deprecated
    ${EXTRA_VALA_OPTIONS}
)

set(LIB_PATHS ${DEPS_LIBRARY_DIRS})
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS} "-DGETTEXT_PACKAGE=\"wunderlistux\"")

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY
)

add_custom_target(
    uninstall
    COMMAND
        ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake
    COMMAND
        ${glib_schema_compiler} ${GSETTINGS_DIR}
)

add_subdirectory(schemas)
add_subdirectory(icons)
add_subdirectory(data)
add_subdirectory (src)
