angular.module('LoxMeetsBagel.controllers.Main', [])

.controller('MainController', function($scope, $http){
 $http.get('/api/v1.0/token').then(function(data) {
  return console.log('hi');
}, function(data) {
  return console.log('error');
});

  
});