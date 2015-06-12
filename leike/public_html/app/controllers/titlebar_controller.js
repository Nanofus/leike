electronTemplate.controller('TitlebarController', ['$scope', '$interval', function ($scope, $interval) {
        var remote = require('remote');

        var maximizeMode = "maximize";
        $scope.maximizeStyle = {'background-image': 'url(images/titlebar/' + maximizeMode + '.png)'};

        $scope.closeWindow = function () {
            remote.getCurrentWindow().close();
        };

        $scope.minimizeWindow = function () {
            remote.getCurrentWindow().minimize();
        };

        $scope.maximizeWindow = function () {
            if (!remote.getCurrentWindow().isMaximized()) {
                remote.getCurrentWindow().maximize();
            } else {
                remote.getCurrentWindow().unmaximize();
            }
        };

        // RefreshMaximize uses a bit more complex way to check if the app is fullscreen instead of simply using screen events, because they do not fire when using Windows Aero Snap.
        $scope.refreshMaximize = function () {
            var atomScreen = require('screen');
            if ((remote.getCurrentWindow().getBounds().width >= atomScreen.getDisplayMatching(remote.getCurrentWindow().getBounds()).workAreaSize.width) && (remote.getCurrentWindow().getBounds().height >= atomScreen.getDisplayMatching(remote.getCurrentWindow().getBounds()).workAreaSize.height)) {
                maximizeMode = "restore";
            } else {
                maximizeMode = "maximize";
            }
            
            $scope.maximizeStyle = {'background-image': 'url(images/titlebar/' + maximizeMode + '.png)'};
            $scope.$digest();
            $scope.$apply();
        };

        //Auto-refresh for maximize button icon
        $interval(function () {
            $scope.refreshMaximize();
        }, 10, 0, false);

    }]);