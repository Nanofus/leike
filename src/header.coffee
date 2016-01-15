# Header
headerData = { upAv: updateAvailable }
header = new Vue(
  el: 'header'
  data: headerData
  methods:

    # The window buttons

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
      showWindow('config')
)

# Temp solution to change different statuses
setInterval (->
  if headerData.upAv != updateAvailable
    headerData.upAv = updateAvailable
), 3000
