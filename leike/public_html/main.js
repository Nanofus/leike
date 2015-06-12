/* Base main.js contents from here: https://github.com/atom/electron/blob/master/docs/tutorial/quick-start.md */

var app = require('app');
var BrowserWindow = require('browser-window');
var mainWindow = null;

var Menu = require('menu');
var Tray = require('tray');
var appIcon = null;

app.on('window-all-closed', function () {
    //if (process.platform != 'darwin')
    //  app.quit();
});

app.on('ready', function () {
    mainWindow = new BrowserWindow({width: 300, height: 600, frame: false});
    mainWindow.loadUrl('file://' + __dirname + '/index.html');
    mainWindow.openDevTools();

    mainWindow.on('closed', function () {
        mainWindow = null;
    });

    appIcon = new Tray('images/trayicon.png');
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
    appIcon.addListener('clicked', function () {
        mainWindow.show();
    });
});