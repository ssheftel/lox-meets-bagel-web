angular.module('LoxMeetsBagel.controllers.Profile', [])
.controller( 'ProfileController', ($scope, uc, PhotoService) ->
  $scope.photoService = PhotoService
  $scope.upload = () ->
    file = $scope.myFile
    if file
      PhotoService.uploadPhoto(uc.get('id'), file)

  return

)