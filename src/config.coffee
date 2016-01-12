configWindow = new Vue(
  el: '#config'
  data: {
    packageJson: packageJson,
    configJson: configJson
  }
)

checkIfDevVersion= ->
  if app.getAppPath().indexOf("electron-prebuilt") > -1
    console.log("Running dev version")
    devVersion = true

setupConfig= ->
  if devVersion
    defaultConfigPath = "default_config.json"
  else
    defaultConfigPath = "resources/app/default_config.json"
  if !fileExists(configPath)
    copyFileSync(defaultConfigPath,configPath)

reloadConfig= ->
  configJson = readJsonSync(configPath)
  loadCss("build/css/" + configJson.style + ".css")
  if configJson.debugEnabled
    remote.getCurrentWindow().webContents.openDevTools()
  # Hide loading screen
  document.getElementById("loading-window").style.display = "none"
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

# Config initialization

checkIfDevVersion()
setupConfig()
reloadConfig()
