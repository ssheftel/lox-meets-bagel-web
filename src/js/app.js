angular.module('LoxMeetsBagel', [
  'ngRoute',
  'mobile-angular-ui',
  'LoxMeetsBagel.controllers.Main'
])

.config(function($routeProvider) {
  $routeProvider.when('/', {templateUrl:'home.html',  reloadOnSearch: false});
});