
const {app, BrowserWindow, dialog} = require('electron');
const windowStateKeeper = require('electron-window-state');

let win;

app.on('window-all-closed', function() {
  app.quit();
});

let quitApp = function(){ app.quit() }

app.on('ready', function() {
  var size = { width: 400, height: 500 };

  let winState = windowStateKeeper({
    defaultWidth: size.width,
    defaultHeight: size.height
  });

  win = new BrowserWindow({
    // Min size
    minWidth: size.width,
    minHeight: size.height,
    // Window style
    transparent: true,
    frame: false,
    radii: [10,10,10,10],
    // Window state
    x: winState.x,
    y: winState.y,
    icon: __dirname + '/images/icon.png',
    width: winState.width,
    height: winState.height
  });

  win.loadURL('file://' + __dirname + '/index.html');
  // win.openDevTools();
  winState.manage(win);
});
