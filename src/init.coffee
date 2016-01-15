# Requirements
remote = require('remote')
clipboard = remote.require('clipboard')
fs = remote.require('fs-extra')
shell = remote.require('shell')
app = remote.require('electron').app;
packageJson = require('../package.json')

# Other values
filePath = app.getPath('documents') + '\\LeikeData\\'
imagePath = filePath + "images\\"
textPath = filePath + "data\\"
configPath = filePath + "config.json"
defaultConfigPath = "default_config.json" # Overridden by config.js
devVersion = false

updateAvailable = false

# Methods

openLinkExternally= (url) ->
  shell.openExternal(url)

openFilePath= ->
  shell.showItemInFolder(filePath)

openInFileManager= (path) ->
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

exportJson= (autosave) ->
  time = new Date
  if autosave
    path = entryList.writeData(entryList.entries, 'autosave')
  else
    path = entryList.writeData(entryList.entries, time.getFullYear() + '-' + time.getMonth() + 1 + '-' + time.getDate() + ' ' + time.getHours() + '-' + time.getMinutes() + '-' + time.getSeconds() + '-' + time.getMilliseconds())
    openInFileManager(path)

deleteAllData= ->
  clearEntries()
  fs.remove filePath, (err) ->
    if err
      throw err
    return

checkForUpdates= ->
  request = new XMLHttpRequest
  request.open 'GET', 'https://api.github.com/repos/Nanofus/leike/tags', true
  request.onload = ->
    if request.status >= 200 and request.status < 400
      # Success!
      data = JSON.parse(request.responseText)
      newVersionNumber = data[0].name.substring(1) # Remove the 'v'
      if newVersionNumber != packageJson.version
        updateAvailable = true
        console.log('New version available')
      else
        updateAvailable = false
        console.log('No update available')
    else
      # We reached our target server, but it returned an error
      console.log('Error from server when checking for updates: ' + request.status)
    return
  request.onerror = ->
    # There was a connection error of some sort
    console.log('Could not check for updates - connection error')
    return
  request.send()
