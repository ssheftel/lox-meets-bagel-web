angular.module('LoxMeetsBagel.controllers.Profile', [])
.controller( 'ProfileController', ($scope, info, APP_CONFIG, AccountService, FileUploadService, TokenService) ->
  $scope.info = info
  $scope.thumbImage = (userObj) ->
    if userObj.photo_name
      imgurl = APP_CONFIG.thumbUrl.replace('{{userId}}', userObj.photo_name)
    else
      imgurl = APP_CONFIG.thumbUrl.replace('{{userId}}', APP_CONFIG.defaultFace)
    return imgurl
  $scope.uploadFile = () ->
    file = $scope.myFile
    if file
      uploadUrl = APP_CONFIG.uploadPhoto.replace('{{userId}}', TokenService.getId())
      `debugger`
      FileUploadService.uploadFileToUrl(file, uploadUrl)

  return

)