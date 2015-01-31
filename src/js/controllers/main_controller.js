angular.module("LoxMeetsBagel.controllers.Main", []).controller("MainController", function($scope, $state, TokenService) {
  return $scope.logout = function() {
    TokenService.clearCache();
    $state.go('login');
  };
});
