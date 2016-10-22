
const {app, BrowserWindow, dialog} = require('electron');

let mainWindow;

app.on('window-all-closed', function() {
  app.quit();
});

let quitApp = function(){ app.quit() }

app.on('ready', function() {
  var size = { width: 400, height: 500 };
  mainWindow = new BrowserWindow({
    trasnparent: true,
    width: size.width,
    height: size.height,
    frame: false,
    minWidth: size.width,
    minHeight: size.height,
    radii: [10,10,10,10]
  });

  mainWindow.loadURL('file://' + __dirname + '/index.html');
  // mainWindow.openDevTools();
});
