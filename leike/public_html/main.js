/* Base main.js contents from here: https://github.com/atom/electron/blob/master/docs/tutorial/quick-start.md */

var app = require('app');
var BrowserWindow = require('browser-window');
var mainWindow = null;

app.on('window-all-closed', function() {
  if (process.platform != 'darwin')
    app.quit();
});

app.on('ready', function() {
  mainWindow = new BrowserWindow({width: 800, height: 600, frame: false});
  mainWindow.loadUrl('file://' + __dirname + '/index.html');
  mainWindow.openDevTools();

  mainWindow.on('closed', function() {
    mainWindow = null;
  });
});