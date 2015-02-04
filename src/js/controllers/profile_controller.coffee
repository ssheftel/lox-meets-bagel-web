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
.controller( 'ProfileController', ($scope, uc, PhotoService) ->
  $scope.photoService = PhotoService
  $scope.photo_name = uc.get('photo_name')
  $scope.upload = () ->
    file = $scope.myFile
    if file
      PhotoService.uploadPhoto(uc.get('id'), file).then ({has_photo, photo_name}) ->
        $scope.photo_name = photo_name

  return

)