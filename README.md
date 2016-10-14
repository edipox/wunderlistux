# Wunderlistux
An electron wrapper for wunderlist made with :heart: for Linux (specially for [elementary OS](http://elementary.io))


## Screenshots
Screenshots taken in [elementary OS Loki](http://elementary.io)



## Install
### Linux
[Download the last release](https://github.com/edipox/wunderlistux/releases/latest).

Add an app shortcut. Create a file in ~/.local/share/applications called wunderlistux.desktop with the following contents:
```
[Desktop Entry]
Name=Wunderlistux
Exec=/path/to/Wunderlistux-linux-x64/Wunderlistux
Terminal=false
Type=Application
Icon=/path/to/Wunderlistux-linux-x64/resources/app/images/wunderlist.png
```
Or just copy the wunderlistux.desktop file from the release you downloaded. You have to edit the file anyway to fix the paths.

## TODO
* Color picker to customize headerbar.
* Add support for other OSs.

## Credits
* Those amazing icons where stolen from [elementary OS](http://elementary.io). Here is the [github project](https://github.com/elementary/icons). I think those were made by [Daniel Foré](https://github.com/danrabbit) and [Sam Hewitt](https://github.com/snwh).
* Inspired by [Caprine](https://github.com/sindresorhus/caprine) and [Skype-Electron](https://github.com/GyozaGuy/Skype-Electron)
