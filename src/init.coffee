# Requirements
remote = require('remote')

remote.getCurrentWindow().webContents.openDevTools()
clipboard = remote.require('clipboard')
fs = remote.require('fs-extra')
shell = remote.require('shell')
app = remote.require('electron').app;
packageJson = require('../package.json')
configJson = require('../default_config.json') # Overridden by config.js

# Other values
filePath = app.getPath('home') + '\\LeikeData\\'
imagePath = filePath + "images\\"
textPath = filePath + "data\\"
configPath = filePath + "config.json"
defaultConfigPath = "default_config.json" # Overridden by config.js
devVersion = false

# Methods

openLinkExternally= (url) ->
  shell.openExternal(url)

openFilePath= ->
  shell.showItemInFolder(filePath)

openInFileManager= (path) ->
  #console.log("opening " + path)
  shell.showItemInFolder(path)

fileExists= (path) ->
  try
    fs.statSync path
  catch err
    return false
  return true

copyFileSync= (from, to) ->
  try
    fs.copySync from, to
  catch err
    console.error 'File copy failed: ' + err.message

readJson= (path) ->
  fs.readJson path, (err, obj) ->
    return obj

readJsonSync= (path) ->
  obj = fs.readJsonSync(path, throws: false)
  return obj

writeJsonSync= (data, path) ->
  fs.writeJsonSync path, data

exportJson= ->
  time = new Date
  path = entryList.writeData(entryList.entries, time.getFullYear() + '-' + time.getMonth() + 1 + '-' + time.getDate() + ' ' + time.getHours() + '-' + time.getMinutes() + '-' + time.getSeconds() + '-' + time.getMilliseconds())
  openInFileManager(path)

deleteAllData= ->
  clearEntries()
  fs.remove filePath, (err) ->
    if err
      throw err
    return
