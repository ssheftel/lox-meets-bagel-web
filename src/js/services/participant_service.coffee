angular.module(
  'LoxMeetsBagel.services.ParticipantService', []
).
factory 'ParticipantService', (APP_CONFIG, $http) ->
  #APP_CONFIG.match# = /api/v1.0/user
  participantService = {}
  participantService.participants = []
  #Promise for matches
  participantService.load = (genderFilter=null) ->
    url = if genderFilter then "#{APP_CONFIG.user}?gender=#{genderFilter}" else APP_CONFIG.user
    return $http.get(url).then (resp) ->
      participantService.participants = resp.data
      return participantService.participants


  return participantService
