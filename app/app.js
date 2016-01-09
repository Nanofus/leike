var remote = require('remote');
var clipboard = remote.require('clipboard');
var currentClipboard = clipboard.readText();
var fs = remote.require('fs');

var entries = new Array();

var vm = new Vue({
  el: '#entry-list',
  data: {
    entries: entries
  },
  methods: {
    say: function (msg) {
      this.saveToClipboard();
    },

    writeImage: function (data, name) {
        fs.writeFile('clipboard_images/' + name + '.png', data, function (err) {
            if (err) {
                throw err;
            }
        });
    },

    saveToClipboard: function() {
        var clipboardData;
        var time = (new Date).getTime();
        var writeImage = this.writeImage;
        if (clipboard.readText() !== currentClipboard && clipboard.readText() !== "") {
            clipboardData = {content: clipboard.readText(), timestamp: time};
            //console.log("Data is text! - " + clipboardData);
            currentClipboard = clipboard.readText();
            entries.push(clipboardData);
        } else if (clipboard.readImage().toPng().toString() !== currentClipboard && !clipboard.readImage().isEmpty()) {
            writeImage(clipboard.readImage().toPng(), time);
            clipboardData = {content: "[image]", timestamp: time};
            currentClipboard = clipboard.readImage().toPng().toString();
            //console.log("Data is an image! - " + clipboardData);
            entries.push(clipboardData);
        }
    }
  }
})
