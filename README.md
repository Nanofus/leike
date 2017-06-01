# ![Leike](https://raw.githubusercontent.com/Nanofus/leike/master/app/img/icon-32px.png "Leike") Leike
[![Dependency Status](https://david-dm.org/Nanofus/leike.svg)](https://david-dm.org/Nanofus/leike) [![devDependency Status](https://david-dm.org/Nanofus/leike/dev-status.svg)](https://david-dm.org/Nanofus/leike#info=devDependencies)
[![Github All Releases](https://img.shields.io/github/downloads/Nanofus/leike/total.svg)]() [![GitHub release](https://img.shields.io/github/release/Nanofus/leike.svg)]()

A clipboard management utility, using [Electron](https://github.com/atom/electron) & [Vue.js](https://github.com/vuejs/vue). Written in [CoffeeScript](https://github.com/jashkenas/coffeescript), HTML & [SASS](https://github.com/sass/sass). Works on Windows and Ubuntu, untested on OSX and other flavors of Linux.

## Features

* Records text & images from the clipboard
* Backups images in a folder
* Copied links are clickable
* Data can be exported as JSON
* A neat user interface
* Multiple color schemes
* Runs silently in the background...
* ...if the optional notification sounds aren't on
* Automatic update checking

The application can be quit by right-clicking the tray icon.

## Planned features

* Changeable data folder location
* Bugfixes for Linux version
* Optimizations to limit CPU usage when handling images
* OSX version

## Downloads

The latest build is available on the [releases](https://github.com/Nanofus/leike/releases/latest) page.

## Building

Running dev version:

```sh
# Install dependencies
npm install

# Compile SASS & CoffeeScript using Gulp
gulp

# Run
npm start
```

Building dist version:

```sh
# Install dependencies
npm install

# Build standalone Windows and Linux apps into ./dist
npm run build
```

Other configured scripts:

```sh
# Clean compiled stylesheets & scripts
gulp clean

# Clean compiled dist versions
npm run clean

# Watch for changes in stylesheets & scripts
gulp watch
```
