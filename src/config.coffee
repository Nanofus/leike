# Requirements
packageJson = require('../package.json')
configJson = require('../config.json')
remote = require('remote')
app = remote.require('electron').app
if app.getAppPath().indexOf("electron-prebuilt") > -1
  console.log("Running dev version")
  devVersion = true

if devVersion
  configPath = "config.json"
else
  configPath = "resources/app/config.json"

configWindow = new Vue(
  el: '#config'
  data: {
    packageJson: packageJson,
    configJson: configJson
  }
)

reloadConfig= ->
  configJson = readJsonSync(configPath)
  loadCss("build/css/" + configJson.style + ".css")
  if configJson.debugEnabled
    remote.getCurrentWindow().webContents.openDevTools()
  return

saveConfig= ->
  writeJsonSync(configWindow.configJson,configPath)
  reloadConfig()
  return

loadCss= (url) ->
  head = document.getElementsByTagName('head')[0]
  link = document.createElement('link')
  link.type = 'text/css'
  link.rel = 'stylesheet'
  link.href = url
  head.appendChild link
  return link

reloadConfig()
