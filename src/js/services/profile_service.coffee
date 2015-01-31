angular.module(
  'LoxMeetsBagel.services.ProfileService', []
).
factory 'ProfileService', (APP_CONFIG, $http) ->
  #APP_CONFIG.match# = /api/v1.0/match

  profileService = {}
  profileService.getThumb = (userId) -> APP_CONFIG.thumbUrl.replace('{{userId}}', userId)
  profileService.getPhoto = (userId) -> APP_CONFIG.photoUrl.replace('{{userId}}', userId)


  return profileService
