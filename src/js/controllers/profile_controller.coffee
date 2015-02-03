angular.module('LoxMeetsBagel.controllers.Profile', [])
.directive( 'ngFileSelect', ->
  { link: ($scope, el) ->
    el.bind 'change', (e) ->
      $scope.file = (e.srcElement or e.target).files[0]
      $scope.upload()
      return
    return
  }
)
.controller( 'ProfileController', ($scope, uc, PhotoService, $state) ->
  $scope.photoService = PhotoService
  $scope.upload = () ->
    file = $scope.myFile
    if file
      PhotoService.uploadPhoto(uc.get('id'), file)
      #TODO RELOAD STATE

  return

)