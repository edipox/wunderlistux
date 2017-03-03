#!/bin/bash
APPNAME=Wunderlistux
VERSION=1.6.1
electron-packager . $APPNAME --platform=win32 --arch=x64 --version=$VERSION --overwrite=true --asar=false --app_version=0.0.1 --appname=$APPNAME --out=releases --overwrite=true --icon=images/app.ico
