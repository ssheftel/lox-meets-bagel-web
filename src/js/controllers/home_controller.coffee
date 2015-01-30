angular.module('LoxMeetsBagel.controllers.Home', [])
.controller( 'HomeController', ($scope, userId, accountService, APP_CONFIG) ->
  $scope.last_name = accountService.last_name
)