angular.module('LoxMeetsBagel.controllers.Home', ['LoxMeetsBagel.services.AccountService'])
.controller( 'HomeController', ($scope, userId, AccountService, APP_CONFIG) ->
  $scope.last_name = AccountService.last_name
)