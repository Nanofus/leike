# Requirements
remote = require('remote')
clipboard = remote.require('clipboard')
fs = remote.require('fs-extra')
shell = remote.require('shell')
app = remote.require('electron').app;
packageJson = require('../package.json');

# Other values
filePath = app.getPath('documents') + '/leike/'
filePathBackslash = app.getPath('documents') + '\\leike\\'
entries = new Array
currentClipboard = clipboard.readImage().toPng().toString()

openLinkExternally= (url) ->
  shell.openExternal(url)

openFilePath= ->
  shell.showItemInFolder(filePath)

showFaq= () ->
  if document.getElementById("faq").style.display == "block"
    document.getElementById("faq").style.display="none"
  else
    document.getElementById("faq").style.display="block"

header = new Vue(
  el: 'header'
  methods:
    closeWindow: ->
      remote.getCurrentWindow().hide()

    maximizeWindow: ->
      if !remote.getCurrentWindow().isMaximized()
        remote.getCurrentWindow().maximize()
      else
        remote.getCurrentWindow().unmaximize()

    minimizeWindow: ->
      remote.getCurrentWindow().minimize()

    openSettings: ->
      # Open dev tools
      remote.getCurrentWindow().webContents.openDevTools();
)

faq = new Vue(
  el: '#faq'
  data: packageJson: packageJson
)

vm = new Vue(
  el: '#entry-list'
  data: entries: entries
  methods:
    writeImage: (data, name) ->
      fs.ensureDir filePath, (err) ->
        if err
          throw err
        return
      fs.writeFile filePath + name + '.png', data, (err) ->
        if err
          throw err
        return
      filePathBackslash + name + '.png'

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
        currentClipboard = clipboard.readImage().toPng().toString()
        #console.log("Data is an image! - " + clipboardData);
        entries.unshift clipboardData

    openInFileManager: (path) ->
      #console.log("opening " + path)
      shell.showItemInFolder(path)

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
  if clipboard.readText() != currentClipboard and clipboard.readText() != ''
    vm.saveToClipboard('text')
  else if clipboard.readImage().toPng().toString() != currentClipboard and !clipboard.readImage().isEmpty()
    vm.saveToClipboard('image')
), 500
