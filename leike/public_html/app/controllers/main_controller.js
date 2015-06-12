leike.controller('MainController', ['$scope', '$interval', function ($scope, $interval) {
        var remote = require('remote');
        var clipboard = remote.require('clipboard');
        var currentClipboard;
        var fs = remote.require('fs');

        $scope.items = new Array();

        function saveClipboard() {
            if (clipboard.readText() !== $scope.items[$scope.items.length - 1]) {
                $scope.items.push(clipboard.readText());
            } else if (clipboard.readImage() !== $scope.items[$scope.items.length - 1]) {
                console.log("Image detected! fs: "+fs);
                /*fs.writeFile('tempimage.png', clipboard.readImage().toPng(), function (err) {
                    if (err) {
                        return console.log(err);
                    }
                });*/

            }
        }

        //Auto-refresh
        $interval(function () {
            if (clipboard.readText() !== currentClipboard) {
                saveClipboard();
                currentClipboard = clipboard.readText();
            }
        }, 10, 0, false);

    }]);