# Requirements
remote = require('remote')
clipboard = remote.require('clipboard')
fs = remote.require('fs-extra')
shell = remote.require('shell')
app = remote.require('electron').app;
packageJson = require('../package.json')

# Other values
filePath = app.getPath('home') + '\\LeikeData\\'
imagePath = filePath + "images\\"
textPath = filePath + "data\\"
entries = new Array
currentClipboard = clipboard.readImage().toJpeg(0).toString()
console.log(currentClipboard)

openLinkExternally= (url) ->
  shell.openExternal(url)

openFilePath= ->
  shell.showItemInFolder(filePath)

readJson= (path) ->
  fs.readJson path, (err, obj) ->
    return obj

readJsonSync= (path) ->
  obj = fs.readJsonSync(path, throws: false)
  return obj

writeJsonSync= (data, path) ->
  fs.writeJsonSync path, data

entryList = new Vue(
  el: '#entry-list'
  data: entries: entries
  methods:
    writeImage: (data, name) ->
      fs.ensureDir imagePath, (err) ->
        if err
          throw err
        return
      fs.writeFile imagePath + name + '.png', data, (err) ->
        if err
          throw err
        return
      imagePath + name + '.png'

    writeData: (data, name) ->
      fs.ensureDir textPath, (err) ->
        if err
          throw err
        return
      fs.writeJson textPath + name + '.json', data, (err) ->
        if err
          throw err
        return
      textPath + name + '.json'

    exportJson: ->
      path = @writeData(entries, time.getFullYear() + '-' + time.getMonth() + 1 + '-' + time.getDate() + ' ' + time.getHours() + '-' + time.getMinutes() + '-' + time.getSeconds() + '-' + time.getMilliseconds())
      @openInFileManager(path)

    saveToClipboard: (type) ->
      time = new Date
      if type == 'text'
        if !remote.getCurrentWindow().isFocused()
          clipboardData =
            content: clipboard.readText()
            type: 'text'
            timestamp: time
          #console.log("Data is text!")
          #console.log(clipboardData)
          currentClipboard = clipboard.readText()
          entries.unshift clipboardData
        else
          currentClipboard = clipboard.readText()
      else if type == 'image'
        path = @writeImage(clipboard.readImage().toPng(), time.getFullYear() + '-' + time.getMonth() + 1 + '-' + time.getDate() + ' ' + time.getHours() + '-' + time.getMinutes() + '-' + time.getSeconds() + '-' + time.getMilliseconds())
        clipboardData =
          content: path
          type: 'image'
          timestamp: time
        currentClipboard = clipboard.readImage().toJpeg(0).toString()
        #console.log("Data is an image! - " + clipboardData);
        entries.unshift clipboardData

    openInFileManager: (path) ->
      #console.log("opening " + path)
      shell.showItemInFolder(path)

    copyEntry: (entry) ->
      if entry.type == 'text'
        clipboard.writeText(entry.content)

    deleteEntry: (entry) ->
      #console.log("deleting " + entry)
      if entry.type == 'image'
        fs.unlink entry.content, (err) ->
          if err
            throw err
          return
      index = @entries.indexOf(entry)
      if index > -1
        @entries.splice(index, 1)
)

setInterval (->
  readText = clipboard.readText()
  if readText!= currentClipboard and readText != ''
    entryList.saveToClipboard('text')
  else
    readImage = clipboard.readImage()
    if readImage.toJpeg(0).toString() != currentClipboard
      if !readImage.isEmpty()
        entryList.saveToClipboard('image')

), 250
