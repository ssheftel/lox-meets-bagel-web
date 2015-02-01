#AuthService
angular.module(
  'LoxMeetsBagel.services.TokenService', ['LoxMeetsBagel.services.LocalStorageService']
).
factory(
  'TokenService', (APP_CONFIG, $http, $window, $state, LocalStorageService) ->
    #APP_CONFIG.token# = /api/v1.0/token
    ###
    ls = $window.localStoreage or {}
    tokenService.clearCache() -> null
    tokenService.getToken = cached token
    tokenService.getId() = cached id
    tokenService.Load() -> Promis for {token, id}
    tokenService.login(email, password) -> promist that
    ###

    tokenService = {}

    tokenService.clearCache = ->
        LocalStorageService.removeItem('id')
        LocalStorageService.removeItem('token')
        LocalStorageService.removeItem('gender')
        null

    tokenService.getToken = -> LocalStorageService.getItem('token')
    tokenService.getId = -> LocalStorageService.getItem('id')
    tokenService.getGender = -> localStorage.getItem('gender')
    tokenService.load = ->
        return $http.get(APP_CONFIG.token).then (resp) ->
            token = resp.data.token
            id = resp.data.id
            gender = resp.data.gender
            if token != LocalStorageService.getItem('token')
              LocalStorageService.setItem('token', token)
            if id != LocalStorageService.getItem('id')
              LocalStorageService.setItem('id', id)
            if gender != LocalStorageService.getItem('gender')
              LocalStorageService.setItem('gender', gender)
            return {token, id, gender}

    tokenService.login = (email, password) ->
        return $http.post(APP_CONFIG.token, {email, password}, headers: {'TOKEN': "#{email}:#{password}"}).then (resp) ->
            token = resp.data.token
            id = resp.data.id
            gender = resp.data.gender
            if token != LocalStorageService.getItem('token')
              LocalStorageService.setItem('token', token)
            if gender != LocalStorageService.getItem('gender')
              LocalStorageService.setItem('gender', gender)
            return {token, id, gender}


    tokenService
)