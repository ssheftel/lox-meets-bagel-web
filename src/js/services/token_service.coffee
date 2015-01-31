#AuthService
angular.module(
  'LoxMeetsBagel.services.TokenService', []
).
factory(
  'TokenService', (APP_CONFIG, $http, $window, $state) ->
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

    tokenService.ls = $window.localStorage or {}
    tokenService.clearCache = ->
        delete tokenService.ls['id']
        delete tokenService.ls['token']
        null

    tokenService.getToken = -> tokenService.ls['token']
    tokenService.getId = -> tokenService.ls['id']
    tokenService.load = ->
        return $http.get(APP_CONFIG.token).then (resp) ->
            token = resp.data.token
            id = resp.data.id
            if token != tokenService.ls['token']
                tokenService.ls['token'] = token
            if id != tokenService['id']
                tokenService.ls['id'] = id
            return {token, id}

    tokenService.login = (email, password) ->
        return $http.post(APP_CONFIG.token, {email, password}).then (resp) ->
            token = resp.data.token
            id = resp.data.id
            if token != tokenService.ls['token']
                tokenService.ls['token'] = token
            if id != tokenService['id']
                tokenService.ls['id'] = id
            return {token, id}


    tokenService
)