angular.module("LoxMeetsBagel.controllers.Main", ['LoxMeetsBagel.services.TokenService', 'LoxMeetsBagel.services.AccountService']).
controller "MainController", ($scope, $state, TokenService, AccountService) ->
  $scope.globals = {}
  $scope.globals.$state = $state
  $scope.globals.AccountService = AccountService
  $scope.globals.TokenService = TokenService

  $scope.logout = ->
    TokenService.clearCache()
    $state.go('login')
    return
