remote = require('remote')
clipboard = remote.require('clipboard')
currentClipboard = clipboard.readText()
fs = remote.require('fs-extra')
shell = remote.require('shell')

app = remote.require('electron').app;

entries = new Array

filePath = app.getPath('desktop') + '\\leike_images\\'

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
      filePath + name + '.png'

    saveToClipboard: ->
      time = new Date
      if clipboard.readText() != currentClipboard and clipboard.readText() != ''
        clipboardData =
          content: clipboard.readText()
          type: 'text'
          timestamp: time
        console.log("Data is text!")
        console.log(clipboardData)
        currentClipboard = clipboard.readText()
        entries.push clipboardData
      else if clipboard.readImage().toPng().toString() != currentClipboard and !clipboard.readImage().isEmpty()
        path = @writeImage(clipboard.readImage().toPng(), time.getFullYear() + '-' + time.getMonth() + 1 + '-' + time.getDate() + ' ' + time.getHours() + '-' + time.getMinutes() + '-' + time.getSeconds() + '-' + time.getMilliseconds())
        clipboardData =
          content: path
          type: 'image'
          timestamp: time
        currentClipboard = clipboard.readImage().toPng().toString()
        #console.log("Data is an image! - " + clipboardData);
        entries.push clipboardData

    openInFileManager: (path) ->
      console.log("opening " + path)
      shell.showItemInFolder(path)

    deleteEntry: (entry) ->
      console.log("deleting " + entry)
      index = @entries.indexOf(entry)
      if index > -1
        @entries.splice(index, 1)
)

setInterval (->
  if clipboard.readText() != currentClipboard
    vm.saveToClipboard()
    currentClipboard = clipboard.readText()
  return
), 20
