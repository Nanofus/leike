setupConfig= ->
  # Check if running from command line
  if app.getAppPath().indexOf("electron-prebuilt") > -1
    console.log("Running dev version")
    devVersion = true
  # Set the default config file's path and create a new config if it doesn't exist
  if devVersion
    defaultConfigPath = "default_config.json"
  else
    defaultConfigPath = "resources/app/default_config.json"
  if !fileExists(configPath)
    copyFileSync(defaultConfigPath,configPath)

reloadConfig= ->
  # Load the config file
  configJson = readJsonSync(configPath)
  # Reload the window's css
  loadCss("build/css/" + configJson.style + ".css")
  # Open dev tools
  if configJson.debugEnabled
    remote.getCurrentWindow().webContents.openDevTools()
  # Hide faq button
  if !configJson.aboutEnabled
    document.getElementById("faq-button").style.display = "none"
  else
    document.getElementById("faq-button").style.display = "initial"
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

setupConfig()
configJson = require(configPath)
reloadConfig()
checkForUpdates()

# Config window
configWindow = new Vue(
  el: '#config'
  data: {
    packageJson: packageJson,
    configJson: configJson
  }
)

# Set autosave
setInterval (->
  exportJson(true)
), configJson.autosaveFrequency * 1000

# Set update checking
setInterval (->
  checkForUpdates()
), configJson.updateCheckFrequency * 1000 * 60
