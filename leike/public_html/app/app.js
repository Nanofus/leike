var leike = angular.module('leike', ['ngRoute']);

leike.config(function($routeProvider){
  $routeProvider
    .when('/', {
      controller: 'MainController',
      templateUrl: 'app/views/mainView.html'
    })
    .otherwise({
      redirectTo: '/'
    });
});