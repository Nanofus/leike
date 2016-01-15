comparationImage= (image) ->
  return image.toJpeg(0).toString()

currentClipboard = comparationImage(clipboard.readImage())
copiedImage = null

clearEntries= ->
  entryList.entries = new Array

entryList = new Vue(
  el: '#entry-list'
  data: { entries: new Array }
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

    openInFileManager: (path) ->
      openInFileManager(path)

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
          @entries.unshift clipboardData
        else
          currentClipboard = clipboard.readText()
      else if type == 'image'
        path = @writeImage(clipboard.readImage().toPng(), time.getFullYear() + '-' + time.getMonth() + 1 + '-' + time.getDate() + ' ' + time.getHours() + '-' + time.getMinutes() + '-' + time.getSeconds() + '-' + time.getMilliseconds())
        clipboardData =
          content: path
          type: 'image'
          timestamp: time
        currentClipboard = comparationImage(clipboard.readImage())
        #console.log("Data is an image! - " + clipboardData);
        @entries.unshift clipboardData

    copyEntry: (entry) ->
      if entry.type == 'text'
        clipboard.writeText(entry.content)
      if entry.type == 'image'
        img = nativeImage.createFromPath(entry.content)
        clipboard.writeImage(img)
        copiedImage = comparationImage(img)

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

checkForClipboardChanges= ->
  readText = clipboard.readText()
  if readText != ''
    if readText!= currentClipboard
      entryList.saveToClipboard('text')
  else
    readImage = clipboard.readImage()
    compImage = comparationImage(readImage)
    if compImage != currentClipboard
      if compImage != copiedImage
        if !readImage.isEmpty()
          entryList.saveToClipboard('image')

setInterval (->
  checkForClipboardChanges()
), 500
