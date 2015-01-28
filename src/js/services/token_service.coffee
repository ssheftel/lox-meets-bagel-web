#AuthService
angular.module(
    'LoxMeetsBagel.services.TokenService', []
).
factory(
    'TokenService', (APP_CONFIG, $http, $window) ->
        #APP_CONFIG.token# = /api/v1.0/token

        tokenService = {}
        tokenService.token = 'Basic none:unused'

        tokenService.get = -> tokenService.token
        
        #Promise for matches
        tokenService.login = (email, password) ->
            #TODO: add error handiler
            #b64 = $window.btoa("#{email}:#{password}") # wont work on IE
            #b64 = "#{email}:#{password}" # wont work on IE
            b64 = $window.btoa("sam.sheftel@gmail.com:password")
            $http.post(APP_CONFIG.token, headers: 'Authenticate': "Basic #{b64}")
                .then (resp) ->
                    tokenService.token = resp.data.token
                    return tokenService.token

        #Promise to Token, loads from server and sets service prop
        tokenService.load = ->
            $http.get(APP_CONFIG.token).then (resp) ->
                tokenService.token = resp.data.token
                return tokenService.token

        tokenService
)