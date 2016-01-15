createWindow = ->
  # Create the browser window.
  mainWindow = new BrowserWindow(
    width: state.width
    height: state.height
    x: state.x
    y: state.y
    frame: false
    'min-width': 560
    'min-height': 350
    'icon': 'img/icon-32px.png')
  # and load the index.html of the app.
  mainWindow.loadURL 'file://' + __dirname + '/index.html'
  mainWindow.on 'close', ->
    position = mainWindow.getPosition()
    size = mainWindow.getSize()
    state.x = position[0]
    state.y = position[1]
    state.width = size[0]
    state.height = size[1]
    saveJson state, 'window-state'
    return
  # Emitted when the window is closed.
  mainWindow.on 'closed', ->
    # Dereference the window object, usually you would store windows
    # in an array if your app supports multi windows, this is the time
    # when you should delete the corresponding element.
    mainWindow = null
    return
  mainWindow.webContents.on 'will-navigate', (ev) ->
    ev.preventDefault()
    return
  return

saveJson = (data, name) ->
  path = app.getPath('documents') + '\\LeikeData\\' + name + '.json'
  fs.writeJson path, data, (err) ->
    console.log err
    return
  return

readJson = (name) ->
  path = app.getPath('documents') + '\\LeikeData\\' + name + '.json'
  fs.readJsonSync path, throws: false

fileExists = (name) ->
  path = app.getPath('documents') + '\\LeikeData\\' + name + '.json'
  try
    fs.statSync path
  catch err
    return false
  true

'use strict'
electron = require('electron')
app = electron.app
BrowserWindow = electron.BrowserWindow
remote = electron.remote
clipboard = electron.clipboard
Menu = require('menu')
Tray = require('tray')
fs = require('fs-extra')
path = require('path')
appIcon = null

state = undefined
if fileExists('window-state')
  state = readJson('window-state')
else
  state =
    x: 100
    y: 100
    width: 560
    height: 800

mainWindow = undefined

shouldQuit = app.makeSingleInstance((commandLine, workingDirectory) ->
  if mainWindow
    mainWindow.show()
    mainWindow.restore()
    mainWindow.focus()
  true
)

if shouldQuit
  app.quit()

app.on 'ready', ->
  createWindow()
  appIcon = new Tray(path.join(__dirname, 'img/icon-16px.png'))
  contextMenu = Menu.buildFromTemplate([
    {
      label: 'Show'
      click: ->
        mainWindow.show()
        return

    }
    {
      label: 'Quit'
      click: ->
        app.quit()
        return

    }
  ])
  appIcon.setToolTip 'leike'
  appIcon.setContextMenu contextMenu
  appIcon.addListener 'click', ->
    mainWindow.show()
    return
  return

app.on 'window-all-closed', ->
  return

app.on 'activate', ->
  if mainWindow == null
    createWindow()
  return
