angular.module(
  'LoxMeetsBagel.services.AccountService', ['LoxMeetsBagel.services.TokenService']
).
factory('AccountService', (APP_CONFIG, $http, TokenService, $q) ->
  userService = {}
  userService.info = {
    'first_name': '',
    'last_name': '',
    'email': '',
    'gender': '',
    'bio': '',
    'age': 0,
    'admin': false,
    'has_photo': false
  }

  userService.getAccountInfo = ->
    return $http.get("#{APP_CONFIG.user}/#{TokenService.getId()}").then( (resp) ->
      data = resp.data
      userService.info.first_name = data.first_name
      userService.info.last_name = data.last_name
      userService.info.email = data.email
      userService.info.gender = data.gender
      userService.info.bio = data.bio
      userService.info.age = data.age
      userService.info.admin = data.admin
      userService.info.has_photo = data.has_photo
      return userService.info
    )


  userService

)