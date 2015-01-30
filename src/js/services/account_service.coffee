angular.module(
  'LoxMeetsBagel.services.AccountService', []
).
factory('AccountService', (APP_CONFIG, $http, TokenService) ->
  userService = {
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
    if not TokenService.getId()
      TokenService.goToLogin()
      return userService
    else
      $http.get("#{APP_CONFIG.user}/#{TokenService.id}").then( (resp) ->
        data = resp.data
        userService.first_name = data.first_name
        userService.last_name = data.last_name
        userService.email = data.email
        userService.gender = data.gender
        userService.bio = data.bio
        userService.age = data.age
        userService.admin = data.admin
        userService.has_photo = data.has_phone
        return userService
      )


  userService

)