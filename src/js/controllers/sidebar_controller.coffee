angular.module('LoxMeetsBagel.controllers.Sidebar', [])
.controller 'SidebarController', ($scope, $rootScope, UserContextService) ->
  $scope.isLoggedIn = if UserContextService.getToken() then true else false
  $scope.$watch UserContextService.getToken, (newVal) ->
    $scope.isLoggedIn = if UserContextService.getToken() then true else false

  $rootScope.isAdmin = UserContextService.isAdmin()
  $scope.$watch UserContextService.isAdmin, (newVal) ->
    $rootScope.isAdmin = newVal