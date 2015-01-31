angular.module("LoxMeetsBagel", [
  'ui.router'
  "mobile-angular-ui"
  "LoxMeetsBagel.controllers.Main"
  #ME
  'LoxMeetsBagel.services.LocalStorageService'
  'LoxMeetsBagel.services.TokenService'
  'LoxMeetsBagel.services.AccountService'
  'LoxMeetsBagel.services.MatchService'
  'LoxMeetsBagel.services.LikeService'

  'LoxMeetsBagel.controllers.Home'
  'LoxMeetsBagel.controllers.Login'
])
.constant( 'APP_CONFIG',
    #APP_CONFIG
    like: '/api/v1.0/like'
    match: '/user/uid/match'
    token: '/api/v1.0/token'
    user: '/api/v1.0/user'
)
.config(
    #Add Auth Headers
    ($httpProvider) ->
        interceptor = (APP_CONFIG, $injector, $q, $rootScope, $location) ->
            request = (config) ->
                TokenService = $injector.get('TokenService')
                config.headers['Authorization'] ?= "Basic #{TokenService.token}"
                return config

            response = (resp) ->
              if resp.config.url == APP_CONFIG.token
                $injector.get('TokenService').token = resp.data.token
                $injector.get('AccountService').id = resp.data.id
              return resp || $q.when(resp)

            responseError = (rejection) ->
              switch rejection.status
                when 401
                  if rejection.config.url != APP_CONFIG.token
                    $rootScope.$broadcast('auth:loginRequired')
                    $location.path('/login')
                when 403 then $rootScope.$broadcast('auth:forbidden')
                when 404 then $rootScope.$broadcast('page:notFound')
                when 500 then $rootScope.$broadcast('server:error')
              return $q.reject(rejection)


            #TODO:Add Error Handler
            {request, response, responseError}
        $httpProvider.interceptors.push(interceptor)

)
.config(
    #Route Config 
    ($stateProvider, $urlRouterProvider) ->
      $urlRouterProvider.otherwise("/home");

      $stateProvider.state 'home',
        url: '/home'
        templateUrl: 'home.html'
        controller: 'HomeController'
        resolve:
          userId: (TokenService) -> TokenService.getId()

      $stateProvider.state 'login',
        url: '/login'
        templateUrl: 'login.html'
        controller: 'LoginController'


      return
)
