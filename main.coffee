'use strict'
electron = require('electron')
# Module to control application life.
app = electron.app
# Module to create native browser window.
BrowserWindow = electron.BrowserWindow
remote = require('electron').remote
clipboard = require('electron').clipboard
# Keep a global reference of the window object, if you don't, the window will
# be closed automatically when the JavaScript object is garbage collected.
mainWindow = undefined

# This method will be called when Electron has finished
# initialization and is ready to create browser windows.
app.on 'ready', ->
  createWindow()
  return

# Quit when all windows are closed.
app.on 'window-all-closed', ->
  # On OS X it is common for applications and their menu bar
  # to stay active until the user quits explicitly with Cmd + Q
  if process.platform != 'darwin'
    app.quit()
  return

app.on 'activate', ->
  # On OS X it's common to re-create a window in the app when the
  # dock icon is clicked and there are no other windows open.
  if mainWindow == null
    createWindow()
  return

createWindow = ->
  # Create the browser window.
  mainWindow = new BrowserWindow(
    width: 750
    height: 1000)
  # and load the index.html of the app.
  mainWindow.loadURL 'file://' + __dirname + '/index.html'
  # Open the DevTools.
  mainWindow.webContents.openDevTools()
  # Emitted when the window is closed.
  mainWindow.on 'closed', ->
    # Dereference the window object, usually you would store windows
    # in an array if your app supports multi windows, this is the time
    # when you should delete the corresponding element.
    mainWindow = null
    return
  return
