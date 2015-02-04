angular.module("LoxMeetsBagel.controllers.Main", ['LoxMeetsBagel.services.UserContextService', 'LoxMeetsBagel.services.TokenService', 'LoxMeetsBagel.services.AccountService']).
controller "MainController", ($scope, $state, $rootScope, UserContextService, PhotoService) ->
  $rootScope.uc = UserContextService
  $rootScope.PhotoService = PhotoService
  $rootScope.$state = $state
  $scope.globals = {}
  $scope.globals.$state = $state

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    $rootScope.loading = true
    return

  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    $rootScope.loading = false
    return

  $rootScope.logout = $scope.logout = ->
    UserContextService.deleteToken()
    UserContextService.clearContext()
    $state.go('login')
    return