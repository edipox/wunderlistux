# Wunderlistux
An electron wrapper for wunderlist made with :heart: for Linux (specially for [elementary OS](http://elementary.io))

## Screenshots
Screenshots taken in the most awesome indie OS: [elementary OS (Loki)](http://elementary.io)

### Elementary
![Screenshots](/images/wunderlistux.png)

### Ambiance
![Screenshots](/images/wunderlistux-ambiance.png)

### Arc Dark
![Screenshots](/images/wunderlistux-arc-dark.png)

### Adwaita
![Screenshots](/images/wunderlistux-adwaita.png)

And others

## Themes
There is a top secret theme selector:

![Screenshots](/images/theme-selector.png)


## Install
### Linux

#### Download the app
[Download the last AppImage](https://github.com/edipox/wunderlistux/releases/latest). An [AppImage](http://appimage.org/) allows you to try the app without installing it. It also allows you to install the app (creating the .desktop file, etc). Just check it out!

#### Install script
[Download the installer](https://raw.githubusercontent.com/edipox/wunderlistux/master/bin/install.sh)
And run it ```sudo install.sh``` as root. Wunderlistux will be automatically installed on your computer.

## Thank you!
If you like the app please :star: the github project.

If you super liked it  [buy me a coffee :coffee:](http://ko-fi.com/A553N9).

If you disliked it you still could :star: the github project and [buy me a coffee :coffee:](http://ko-fi.com/A553N9) :)


## Building

### Install npm
```
sudo apt-get install nodejs npm -y
```

### Fix node missing from PATH issue
```
sudo ln -s /usr/bin/nodejs /usr/bin/node
```

### Install global dependencies
```
sudo npm install electron electron-builder electron-packager electron-prebuilt asar -g
```

### Install electron-builder
Better check electron-builder's doc for updated install instructions: https://github.com/electron-userland/electron-builder/wiki/Multi-Platform-Build

### Install all the dependencies
```
npm install
```

### Build a release
In the project root: ```./bin/build-linux-x64.sh``` or ```./bin/build-linux-ia32.sh```

### Build the AppImage
In the project root: ```build```

## TODO
* Add support for other OSs.

## Credits
* Those amazing icons where stolen from [elementary OS](http://elementary.io). Here is the [github project](https://github.com/elementary/icons). I think those were made by [Daniel Foré](https://github.com/danrabbit) and [Sam Hewitt](https://github.com/snwh).
* Inspired by [Caprine](https://github.com/sindresorhus/caprine) and [Skype-Electron](https://github.com/GyozaGuy/Skype-Electron)
* App icon from https://www.iconfinder.com/megavyto98
* [AppImage app icon](https://commons.wikimedia.org/wiki/File:Wunderlist.png)
