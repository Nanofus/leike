# Requirements
packageJson = require('../package.json')
console.log(packageJson)
configJson = require('../config.json')
console.log(configJson)

configWindow = new Vue(
  el: '#config'
  data: {
    packageJson: packageJson,
    configJson: configJson
  }
)

readConfig= ->
  configJson = readJsonSync("config.json")
  loadCss("build/css/" + configJson.style + ".css")
  if configJson.debugEnabled
    remote.getCurrentWindow().webContents.openDevTools()
  return

saveConfig= ->
  console.log("Before: Style: "+configWindow.configJson.style+", debug: "+configWindow.configJson.debugEnabled)
  writeJsonSync(configWindow.configJson,"config.json")
  readConfig()
  console.log("After: Style: "+configJson.style+", debug: "+configJson.debugEnabled)
  return

loadCss= (url) ->
  head = document.getElementsByTagName('head')[0]
  link = document.createElement('link')
  link.type = 'text/css'
  link.rel = 'stylesheet'
  link.href = url
  head.appendChild link
  return link

readConfig()
