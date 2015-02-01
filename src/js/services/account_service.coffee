angular.module(
  'LoxMeetsBagel.services.AccountService', ['LoxMeetsBagel.services.TokenService']
).
factory('AccountService', (APP_CONFIG, $http, TokenService, $q) ->
  accountService = {}
  accountService.info = {
    'first_name': '',
    'last_name': '',
    'email': '',
    'gender': '',
    'bio': '',
    'age': 0,
    'id': 0,
    'admin': false,
    'has_photo': false,
    'photo_name': 'default_face'
  }

  accountService.getAccountInfo = (userId) ->
    return $http.get("#{APP_CONFIG.user}/#{userId}").then( (resp) ->
      data = resp.data
      info = accountService.info
      info.first_name = data.first_name
      info.last_name = data.last_name
      info.email = data.email
      info.gender = data.gender
      info.id = data.id
      info.bio = data.bio
      info.age = data.age
      info.admin = data.admin
      info.has_photo = data.has_photo
      info.photo_name = data.photo_name
      return accountService.info
    )

  accountService.infoPromise = (userId) ->
    if accountService.info.gender != ''
      return $q.when(accountService.info)
    else
      return accountService.getAccountInfo(userId)

    accountService.attractedToPromise = (userId) ->
      return accountService.infoPromise(userId).then (info) ->
        return if info.gender == 'M' then 'F' else 'M'


  accountService

)