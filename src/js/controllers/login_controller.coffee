angular.module('LoxMeetsBagel.controllers.Login', ['LoxMeetsBagel.services.LocalStorageService', 'LoxMeetsBagel.services.TokenService'])
.controller( 'LoginController', ($scope, TokenService, $state, LocalStorageService) ->
  $scope.rememberMe = true
  if LocalStorageService.getItem('lox_email')
    $scope.email = LocalStorageService.getItem('lox_email')
  if LocalStorageService.getItem('lox_password')
    $scope.password = LocalStorageService.getItem('lox_password')

  $scope.login = (email, password) ->
    TokenService.login(email, password).then ->
      if $scope.rememberMe
        LocalStorageService.setItem('lox_email', email)
        LocalStorageService.setItem('lox_password', password)
      $state.go('home')
  return

)