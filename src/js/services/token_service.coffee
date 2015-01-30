#AuthService
angular.module(
    'LoxMeetsBagel.services.TokenService', []
).
factory(
    'TokenService', (APP_CONFIG, $http, $window, $location) ->
        #APP_CONFIG.token# = /api/v1.0/token

        tokenService = {}
        tokenService.token = 'Basic none:unused'
        tokenService.id = null

        tokenService.get = ->
            if not tokenService.token
                tokenService.goToLogin()
                return null
            return tokenService.token

        tokenService.getId = ->
            if not tokenService.id
                tokenService.goToLogin()
                return null
            return tokenService.id

        tokenService.login = (email, password) ->
            #TODO: add Logging
            $http.post(APP_CONFIG.token, {email, password})
                .then (resp) ->
                    tokenService.token = resp.data.token
                    tokenService.id = resp.data.id
                    return tokenService.token

        #Promise to Token, loads from server and sets service prop
        tokenService.load = ->
            $http.get(APP_CONFIG.token).then (resp) ->
                tokenService.token = resp.data.token
                tokenService.id = resp.data.id
                return tokenService.token

        tokenService.goToLogin = ->
            $location.path('/login')

        tokenService
)