angular.module("LoxMeetsBagel.controllers.Main", ['LoxMeetsBagel.services.TokenService', 'LoxMeetsBagel.services.AccountService']).
controller "MainController", ($scope, $state, $rootScope, TokenService, AccountService) ->
  $scope.globals = {}
  $scope.globals.$state = $state
  $scope.globals.AccountService = AccountService
  $scope.globals.TokenService = TokenService

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    $rootScope.loading = true
    return

  $rootScope.$on 'stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    $rootScope.loading = false
    return

  $scope.logout = ->
    TokenService.clearCache()
    $state.go('login')
    return
