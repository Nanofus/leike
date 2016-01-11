# ![alt text](https://raw.githubusercontent.com/Nanofus/leike/master/app/img/icon-32px.png "leike") leike
A simple clipboard expansion utility, using [Electron](https://github.com/atom/electron) && [Vue.js](https://github.com/vuejs/vue). Written in [CoffeeScript](https://github.com/jashkenas/coffeescript) && [SASS](https://github.com/sass/sass). Works on Windows and Ubuntu, untested on OSX and other flavors of Linux.

## Features

The application runs in the background and records all text and images that enter the clipboard. The text is saved into memory and images copied into a folder (currently desktop). Via the main window the user can view their clipboard log.

The application can be quit by right-clicking the tray icon.

## Building

How to run & build:

```sh
# Install dependencies
npm install

# Compile SASS & CoffeeScript using Gulp
gulp

# Run
npm start

# Build standalone Windows and Linux apps into ./dist
npm run pack
```

Other configured scripts:

```sh
# Clean compiled files
gulp clean

# Clean compiled standalone apps
npm run clean

# Watch for changes in stylesheets & scripts
gulp watch
```

## Todo

* JSON autosave
* JSON export
* OSX version
