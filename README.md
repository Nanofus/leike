# leike
A simple clipboard expansion utility, using [Electron](https://github.com/atom/electron) && [Vue.js](https://github.com/vuejs/vue). Written in [CoffeeScript](https://github.com/jashkenas/coffeescript) && [SASS](https://github.com/sass/sass). Works on Windows, untested on OSX and Linux.

Pre-built binaries coming soon.

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

# Build standalone app into ./dist
npm run pack:win
```

Other configured scripts:

```sh
# Clean compiled files
gulp clean

# Clean compiled builds
npm clean

# Watch for changes in stylesheets & scripts
gulp watch
```

## Todo

* JSON autosave
* JSON export
* Linux & OSX versions
