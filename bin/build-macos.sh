#!/bin/bash
APPNAME=Advantager-Electron
VERSION=1.2.7
electron-packager . $APPNAME --version=$VERSION --platform=darwin --arch=x64 --icon=images/icon.icns  --appname=$APPNAME --out=releases --overwrite=true --asar=false
