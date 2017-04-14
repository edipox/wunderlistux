#!/bin/bash
cd $(dirname $0)/../

APPNAME=Wunderlistux
VERSION=1.6.1
./node_modules/.bin/electron-packager . $APPNAME \
  --version=$VERSION --platform=darwin --arch=x64 \
  --icon=images/icon.icns  --appname=$APPNAME --out=dist \
  --overwrite=true --asar=false
