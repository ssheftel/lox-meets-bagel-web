###
  PhotoService.thumbnailUrl(user)
###
angular.module('LoxMeetsBagel.services.PhotoService', ['LoxMeetsBagel.services.FileUploadService']).
factory 'PhotoService', (APP_CONFIG, FileUploadService) ->
  photoService = {}

  photoService.thumbnailUrl = (userObj_or_photo_name) ->
    photo_name = userObj_or_photo_name.photo_name or userObj_or_photo_name
    return APP_CONFIG.thumbUrl.replace('{{userId}}', photo_name)
  photoService.photoUrl = (userObj_or_photo_name) ->
    photo_name = userObj_or_photo_name.photo_name or userObj_or_photo_name
    return APP_CONFIG.photoUrl.replace('{{userId}}', photo_name)

  photoService.uploadPhoto = (userId, file) ->
    url = APP_CONFIG.uploadPhoto.replace('{{userId}}', userId)
    return FileUploadService.uploadFileToUrl(file, url).then (resp) ->
      {has_photo, photo_name} = resp.data
      {has_photo, photo_name}

  return photoService