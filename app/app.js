var app, clipboard, currentClipboard, entries, filePath, fs, remote, shell, vm;

remote = require('remote');

clipboard = remote.require('clipboard');

currentClipboard = clipboard.readText();

fs = remote.require('fs-extra');

shell = remote.require('shell');

app = remote.require('electron').app;

entries = new Array;

filePath = app.getPath('desktop') + '\\leike_images\\';

vm = new Vue({
  el: '#entry-list',
  data: {
    entries: entries
  },
  methods: {
    writeImage: function(data, name) {
      fs.ensureDir(filePath, function(err) {
        if (err) {
          throw err;
        }
      });
      fs.writeFile(filePath + name + '.png', data, function(err) {
        if (err) {
          throw err;
        }
      });
      return filePath + name + '.png';
    },
    saveToClipboard: function() {
      var clipboardData, path, time;
      time = new Date;
      if (clipboard.readText() !== currentClipboard && clipboard.readText() !== '') {
        clipboardData = {
          content: clipboard.readText(),
          type: 'text',
          timestamp: time
        };
        currentClipboard = clipboard.readText();
        return entries.push(clipboardData);
      } else if (clipboard.readImage().toPng().toString() !== currentClipboard && !clipboard.readImage().isEmpty()) {
        path = this.writeImage(clipboard.readImage().toPng(), time.getFullYear() + '-' + time.getMonth() + 1 + '-' + time.getDate() + ' ' + time.getHours() + '-' + time.getMinutes() + '-' + time.getSeconds() + '-' + time.getMilliseconds());
        clipboardData = {
          content: path,
          type: 'image',
          timestamp: time
        };
        currentClipboard = clipboard.readImage().toPng().toString();
        return entries.push(clipboardData);
      }
    },
    openInFileManager: function(path) {
      console.log("opening " + path);
      return shell.showItemInFolder(path);
    }
  }
});

setInterval((function() {
  if (clipboard.readText() !== currentClipboard) {
    vm.saveToClipboard();
    currentClipboard = clipboard.readText();
  }
}), 20);
