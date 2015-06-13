leike.controller('MainController', ['$scope', '$interval', function ($scope, $interval) {
        var remote = require('remote');
        var clipboard = remote.require('clipboard');
        var currentClipboard = clipboard.readText();
        var fs = remote.require('fs');

        $scope.items = new Array();

        function saveToClipboard() {
            var clipboardData;

            var time = (new Date).getTime();

            if (clipboard.readText() !== currentClipboard && clipboard.readText() !== "") {
                clipboardData = {content: clipboard.readText(), timestamp: time};

                //console.log("Data is text! - " + clipboardData);

                currentClipboard = clipboard.readText();
                $scope.items.push(clipboardData);
            } else if (clipboard.readImage().toPng().toString() !== currentClipboard && !clipboard.readImage().isEmpty()) {
                writeImage(clipboard.readImage().toPng(), time);
                clipboardData = {content: "[image]", timestamp: time};

                currentClipboard = clipboard.readImage().toPng().toString();

                //console.log("Data is an image! - " + clipboardData);

                $scope.items.push(clipboardData);
            }
        }

        function writeImage(data, name) {
            fs.writeFile('clipboard_images/' + name + '.png', data, function (err) {
                if (err) {
                    throw err;
                }
            });
        }

        //Auto-refresh
        $interval(function () {
            if ((clipboard.readText() !== currentClipboard && clipboard.readText !== "") ||
                    (clipboard.readImage() !== currentClipboard && !clipboard.readImage().isEmpty())) {
                saveToClipboard();
            }
        }, 10, 0, false);

    }]);