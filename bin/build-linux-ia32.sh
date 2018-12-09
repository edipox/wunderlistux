#!/bin/bash
cd $(dirname $0)/../

APPNAME=Wunderlistux
VERSION=1.6.2
./node_modules/.bin/electron-packager . $APPNAME \
  --platform=linux --arch=ia32 --version=$VERSION \
  --overwrite=true --asar=false --app_version=0.0.1 \
  --appname=$APPNAME --out=dist --overwrite=true \
  --icon=../images/wunderlist.png
