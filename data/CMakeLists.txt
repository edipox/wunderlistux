install(FILES wunderlistux.desktop DESTINATION share/applications)
install(FILES wunderlistux DESTINATION share/indicators/messages/applications)
INSTALL(FILES default.png DESTINATION share/wunderlistux)
INSTALL(FILES media.png DESTINATION share/wunderlistux)
install(FILES wunderlistux.appdata.xml DESTINATION share/appdata)
install (CODE
"execute_process (COMMAND update-desktop-database)"
)
