# Wunderlistux
An electron wrapper for wunderlist made with :heart: for Linux (specially for [elementary OS](http://elementary.io))

## Screenshots
Screenshots taken in the most awesome indie OS: [elementary OS (Loki)](http://elementary.io)

### Elementary
<p align="center">
  <img alt="elementary screenshot" src="/images/wunderlistux.png" />
</p>

### Ambiance
<p align="center">
  <img alt="ambiance screenshot" src="/images/ambiance.png" />
</p>

### Arc Light
<p align="center">
  <img alt="arc screenshot" src="/images/arc.png" />
</p>

### Arc Dark
<p align="center">
  <img alt="arc dark screenshot" src="/images/arc-dark.png" />
</p>

### Adwaita
<p align="center">
  <img alt="adwaita screenshot" src="/images/adwaita.png" />
</p>


## Settings
There is a top secret settings button:
<p align="center">
  <img alt="settings button screenshot" src="/images/settings-button.png" />
</p>



That opens this settings panel:
<p align="center">
  <img alt="settings panel screenshot" src="/images/settings-panel.png" />
</p>




## Install
### Linux
You can try any of the following methods
#### Download the app
[Download the last AppImage](https://github.com/edipox/wunderlistux/releases/download/Linux-0.0.8/Wunderlistux-0.0.8-x86_64.AppImage). An [AppImage](http://appimage.org/) allows you to try the app without installing it. It also allows you to install the app (creating the .desktop file, etc). Just check it out!
```
# You can make the appImage executable as follows
chmod a+x /path/to/your_app_image
./your_app_image #execute it!
```

#### Install script
[Download the installer](https://github.com/edipox/wunderlistux/releases/download/Linux-0.0.8/install-script.sh)
And run it ```sudo install.sh``` as root. Wunderlistux will be automatically installed on your computer.

## Thank you!
If you like the app please :star: the github project.

If you disliked it you still could :star: the project :)


## Building

### Install npm
```
sudo apt-get install nodejs npm -y
```

### Fix node missing from PATH issue
```
sudo ln -s /usr/bin/nodejs /usr/bin/node
```

### Install dependencies
```
npm install
```

### Install electron-builder
Better check electron-builder's doc for updated install instructions: https://github.com/electron-userland/electron-builder/wiki/Multi-Platform-Build

### Build a release

#### Build Linux tar release
```bash
./bin/build-linux-x64.sh
#or
./bin/build-linux-ia32.sh
```

### Build the rpm package
```bash
./node_modules/.bin/build --linux rpm
```

### Build the deb package
```bash
./node_modules/.bin/build --linux deb
```

### Build the AppImage
```bash
./node_modules/.bin/build --linux AppImage
```

#### Build macOS release
```bash
./bin/build-macos.sh
```

#### Build Windows release
```bash
./bin/build-win.sh
```

## TODO
* Add support for other OSs.

## Credits
* Special thanks to the [impressive contributors](https://github.com/edipox/wunderlistux/graphs/contributors).
* Those amazing icons where stolen from [elementary OS](http://elementary.io). Here is the [github project](https://github.com/elementary/icons). I think those were made by [Daniel Foré](https://github.com/danrabbit) and [Sam Hewitt](https://github.com/snwh).
* Inspired by [Caprine](https://github.com/sindresorhus/caprine) and [Skype-Electron](https://github.com/GyozaGuy/Skype-Electron)
* App icon from https://www.iconfinder.com/megavyto98
* [AppImage app icon](https://commons.wikimedia.org/wiki/File:Wunderlist.png)
