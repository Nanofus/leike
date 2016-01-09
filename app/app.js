var clipboard, currentClipboard, entries, fs, remote, vm;

remote = require('remote');

clipboard = remote.require('clipboard');

currentClipboard = clipboard.readText();

fs = remote.require('fs');

entries = new Array;

vm = new Vue({
  el: '#entry-list',
  data: {
    entries: entries
  },
  methods: {
    writeImage: function(data, name) {
      fs.writeFile('clipboard_images/' + name + '.png', data, function(err) {
        if (err) {
          throw err;
        }
      });
      return 'clipboard_images/' + name + '.png';
    },
    saveToClipboard: function() {
      var clipboardData, path, time, writeImage;
      clipboardData = void 0;
      time = new Date;
      writeImage = this.writeImage;
      if (clipboard.readText() !== currentClipboard && clipboard.readText() !== '') {
        clipboardData = {
          content: clipboard.readText(),
          type: 'text',
          timestamp: time
        };
        currentClipboard = clipboard.readText();
        entries.push(clipboardData);
      } else if (clipboard.readImage().toPng().toString() !== currentClipboard && !clipboard.readImage().isEmpty()) {
        path = writeImage(clipboard.readImage().toPng(), time.getFullYear() + '-' + time.getMonth() + 1 + '-' + time.getDate() + ' ' + time.getHours() + '-' + time.getMinutes() + '-' + time.getSeconds() + '-' + time.getMilliseconds());
        clipboardData = {
          content: path,
          type: 'image',
          timestamp: time
        };
        currentClipboard = clipboard.readImage().toPng().toString();
        entries.push(clipboardData);
      }
    }
  }
});

setInterval((function() {
  if (clipboard.readText() !== currentClipboard) {
    vm.saveToClipboard();
    currentClipboard = clipboard.readText();
  }
}), 100);
