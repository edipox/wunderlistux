#!/bin/bash
APPNAME=Wunderlistux
VERSION=1.6.1
electron-packager . $APPNAME --version=$VERSION --platform=darwin --arch=x64 --icon=images/icon.icns  --appname=$APPNAME --out=releases --overwrite=true --asar=false
