angular.module("LoxMeetsBagel", [
  "ngRoute"
  "mobile-angular-ui"
  "LoxMeetsBagel.controllers.Main"
  #ME
  'LoxMeetsBagel.services.TokenService'
  'LoxMeetsBagel.services.MatchService'
  'LoxMeetsBagel.services.LikeService'
])
.constant( 'APP_CONFIG',
    #APP_CONFIG
    like: '/api/v1.0/like'
    match: '/api/v1.0/match'
    token: '/api/v1.0/token'
)
.config(
    #Add Auth Headers
    ($httpProvider) ->
        interceptor = ($injector) ->
            request = (config) ->
                TokenService = $injector.get('TokenService')
                config.headers['Authorization'] ?= "#{TokenService.token}:unused"
                return config

            #TODO:Add Error Handler
            {request}
        $httpProvider.interceptors.push(interceptor)

)
.config(
    #Route Config 
    ($routeProvider) ->

        $routeProvider.when "/",
            templateUrl: "home.html"
            reloadOnSearch: false
        return
)
