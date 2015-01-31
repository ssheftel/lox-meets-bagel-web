angular.module('LoxMeetsBagel.controllers.Home', ['LoxMeetsBagel.services.AccountService'])
.controller( 'HomeController', ($scope, AccountService, APP_CONFIG, $window, ProfileService) ->
 $scope.img = ProfileService.getPhoto(APP_CONFIG.defaultFace)
)