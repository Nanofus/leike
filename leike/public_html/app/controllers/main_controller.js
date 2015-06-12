leike.controller('MainController', ['$scope', '$interval', function ($scope, $interval) {
        var remote = require('remote');
        var clipboard = remote.require('clipboard');
        var currentClipboard = clipboard.readText();
        var fs = remote.require('fs');

        $scope.items = new Array();

        function saveToClipboard() {
            var clipboardData;

            if (clipboard.readText() !== currentClipboard && clipboard.readText() !== "") {
                clipboardData = clipboard.readText();

                console.log("Data is text! - " + clipboardData);

                currentClipboard = clipboardData;
                $scope.items.push(clipboardData);
            } else if (clipboard.readImage() !== currentClipboard) {
                writeImage(clipboard.readImage().toPng());
                clipboardData = "[image]";

                console.log("Data is an image! - " + clipboardData);

                currentClipboard = clipboardData;
                $scope.items.push(clipboardData);
            }
        }

        function writeImage(data) {
            fs.writeFile('clipboard_images/tempimage.png', data, function (err) {
                if (err)
                    throw err;
                console.log('It\'s saved!');
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