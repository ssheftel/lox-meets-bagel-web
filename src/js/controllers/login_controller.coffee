angular.module('LoxMeetsBagel.controllers.Login', ['LoxMeetsBagel.services.TokenService'])
.controller( 'LoginController', ($scope, TokenService, $state) ->
  $scope.rememberMe = false

  $scope.login = (email, password) ->
    TokenService.login(email, password).then ->
      $state.go('home')
  return

)