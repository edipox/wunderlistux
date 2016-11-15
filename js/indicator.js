'use strict';

const ELECTRON = require('electron');
const PATH = require('path');
const APP = ELECTRON.app;
const MENU = ELECTRON.Menu;
const TRAY = ELECTRON.Tray;
const APPNAME = APP.getName();
const APPICON = PATH.join(__dirname, 'images', 'app.png');

// TODO: read up on modules
// var sysTray = new TRAY;
// var contextMenu = MENU.buildFromTemplate([
//   { label: 'Show', click: function() { /*showAndCenter(mainWindow);*/ console.log('focus()'); } },
//   { label: 'Quit', click: function() { APP.quit(); } }
// ]);
// sysTray.setToolTip(APPNAME);
// sysTray.setContextMenu(contextMenu);
