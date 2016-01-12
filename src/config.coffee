# Requirements
packageJson = require('../package.json')
configJson = require('../default_config.json')
remote = require('remote')
app = remote.require('electron').app
if app.getAppPath().indexOf("electron-prebuilt") > -1
  console.log("Running dev version")
  devVersion = true

if devVersion
  defaultConfigPath = "default_config.json"
else
  defaultConfigPath = "resources/app/default_config.json"

configPath = filePath + "config.json"
if !fileExists(configPath)
  copyFileSync(defaultConfigPath,configPath)
else

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
