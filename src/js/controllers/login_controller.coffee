angular.module('LoxMeetsBagel.controllers.Login', [])
.controller( 'LoginController', ($scope, TokenService, $location) ->
  $scope.rememberMe = false

  $scope.login = (email, password) ->
    TokenService.login(email, password).then ->
      $location.path('/home')
  return

)