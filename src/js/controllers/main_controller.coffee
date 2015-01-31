angular.module("LoxMeetsBagel.controllers.Main", []).
controller "MainController", ($scope, $state, TokenService) ->
  $scope.logout = ->
    TokenService.clearCache()
    $state.go('login')
    return
