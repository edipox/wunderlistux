#!/bin/bash

ARCH=`uname -m`
KERNEL=`uname -s`

if [[ $EUID -ne 0 ]]; then
  echo 'You need to run installer as root!' 2>&1
  exit 1
fi

if [ $KERNEL = 'Linux' ] && [ $ARCH = 'x86_64' ]; then
  URL='https://github.com/edipox/wunderlistux/archive/0.0.5-linux-x64.tar.gz'
else
  URL='https://github.com/edipox/wunderlistux/archive/0.0.4-linux-ia32.tar.gz'
fi

# download builded application and extract in /opt directory
function install {
  echo 'Downloading package...'
  wget -q -O /tmp/wunderlistux.tar.gz $URL
  echo 'Extracting package...'
  mkdir /opt/wunderlistux
  tar -zxf /tmp/wunderlistux.tar.gz -C /opt/wunderlistux --strip-components=1
}

# fix paths in .desktop file
function fix_desktop {
  sed -i 's/path\/to\/Wunderlistux-linux-x64/opt\/wunderlistux/g' /opt/wunderlistux/wunderlistux.desktop
}

# link .desktop file to all users
function create_desktop {
  echo 'Creating shortcut...'
  ln -s /opt/wunderlistux/wunderlistux.desktop /usr/share/applications/
}

install
fix_desktop
create_desktop

echo 'Wunderlistux has been installed successfully :)'
