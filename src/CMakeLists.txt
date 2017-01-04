vala_precompile(VALA_C
    main.vala
PACKAGES
    ${BIRDIE_PACKAGES}
OPTIONS
    ${VALAC_OPTIONS}
)

#Here we define our executable name.
add_executable(wunderlistux
    ${VALA_C} )

add_definitions (${DEPS_CFLAGS})

#We need to link the libraries with our Executable.
target_link_libraries(wunderlistux ${DEPS_LIBRARIES} -lX11 gthread-2.0)

install (TARGETS wunderlistux RUNTIME DESTINATION bin)
