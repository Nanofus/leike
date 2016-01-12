'use strict';

const electron = require('electron');
// Module to control application life.
const app = electron.app;
// Module to create native browser window.
const BrowserWindow = electron.BrowserWindow;

const remote = electron.remote;
const clipboard = electron.clipboard;
const Menu = require('menu');
const Tray = require('tray');

var path = require('path');

var appIcon = null;

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let mainWindow;

function createWindow () {
  // Create the browser window.
  mainWindow = new BrowserWindow({width: 800, height: 900, frame: false, 'min-width': 300, 'min-height': 350, 'icon': 'img/icon-32px.png'});
  // and load the index.html of the app.
  mainWindow.loadURL('file://' + __dirname + '/index.html');

  // Emitted when the window is closed.
  mainWindow.on('closed', function() {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    mainWindow = null;
  });

  mainWindow.webContents.on('will-navigate', ev => {
    ev.preventDefault()
  });
}

var shouldQuit = app.makeSingleInstance(function(commandLine, workingDirectory) {
  // Someone tried to run a second instance, we should focus our window
  if (mainWindow) {
    mainWindow.show();
    mainWindow.restore();
    mainWindow.focus();
  }
  return true;
});

if (shouldQuit) {
  app.quit();
  return;
}


// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
app.on('ready', function () {
    createWindow();

    appIcon = new Tray(path.join(__dirname, 'img/icon-16px.png'));
    var contextMenu = Menu.buildFromTemplate([
      {label: 'Show', click: function () {
        mainWindow.show();
      }},
      {label: 'Quit', click: function () {
        app.quit();
      }}
    ]);
    appIcon.setToolTip('leike');
    appIcon.setContextMenu(contextMenu);
    appIcon.addListener('click', function () {
      mainWindow.show();
    });
});

// Quit when all windows are closed.
app.on('window-all-closed', function () {
  // On OS X it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  /* if (process.platform !== 'darwin') {
    app.quit();
  }*/
});

app.on('activate', function () {
  // On OS X it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (mainWindow === null) {
    createWindow();
  }
});
