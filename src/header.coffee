# Requirements
remote = require('remote')

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
      showWindow('config')
)
