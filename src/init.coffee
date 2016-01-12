# Requirements
remote = require('remote')

remote.getCurrentWindow().webContents.openDevTools()
clipboard = remote.require('clipboard')
fs = remote.require('fs-extra')
shell = remote.require('shell')
app = remote.require('electron').app;
packageJson = require('../package.json')

# Other values
filePath = app.getPath('home') + '\\LeikeData\\'
imagePath = filePath + "images\\"
textPath = filePath + "data\\"
configPath = filePath + "config.json"
defaultConfigPath = "default_config.json" # Overridden by config.js
