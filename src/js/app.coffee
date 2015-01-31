angular.module("LoxMeetsBagel", [
  'ui.router'
  "mobile-angular-ui"
  #ME
  'LoxMeetsBagel.services.TokenService'
  'LoxMeetsBagel.services.LocalStorageService'
  'LoxMeetsBagel.services.AccountService'
  'LoxMeetsBagel.services.ProfileService'
  'LoxMeetsBagel.services.MatchService'
  'LoxMeetsBagel.services.LikeService'

  "LoxMeetsBagel.controllers.Main"
  'LoxMeetsBagel.controllers.Home'
  'LoxMeetsBagel.controllers.Login'
  'LoxMeetsBagel.controllers.Profile'
  'LoxMeetsBagel.controllers.Scroll'
  'LoxMeetsBagel.controllers.Match'
  'LoxMeetsBagel.controllers.Likes'
  'LoxMeetsBagel.controllers.Suggestion'
])
.constant( 'APP_CONFIG',
    #APP_CONFIG
    like: '/api/v1.0/like'
    match: '/user/uid/match'
    token: '/api/v1.0/token'
    user: '/api/v1.0/user'
    photoUrl: 'http://res.cloudinary.com/lox-meets-bagel/image/upload/v1422675531/{{userId}}.jpg'
    thumbUrl: 'http://res.cloudinary.com/lox-meets-bagel/image/upload/w_150,c_scale,c_thumb,g_face/{{userId}}.jpg'
    defaultFace: 'default_face'
)
.config(
    #Add Auth Headers
    ($httpProvider) ->
        interceptor = (APP_CONFIG, $injector, $q, $rootScope) ->
            request = (config) ->
                TokenService = $injector.get('TokenService')
                config.headers['Authorization'] ?= "Basic #{TokenService.getToken()}"
                return config

            responseError = (rejection) ->
              switch rejection.status
                when 401
                  if rejection.config.url != APP_CONFIG.token
                    $rootScope.$broadcast('auth:loginRequired')
                    $injector('$state').go('login')
                when 403 then $rootScope.$broadcast('auth:forbidden')
                when 404 then $rootScope.$broadcast('page:notFound')
                when 500 then $rootScope.$broadcast('server:error')
              return $q.reject(rejection)


            #TODO:Add Error Handler
            {request, responseError}
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
          userId: (TokenService, $q) ->
            TokenService.getId()

      $stateProvider.state 'login',
        url: '/login'
        templateUrl: 'login.html'
        controller: 'LoginController'

      $stateProvider.state 'profile',
        url: '/profile'
        templateUrl: 'profile.html'
        controller: 'ProfileController'

      $stateProvider.state 'scroll',
        url: '/scroll'
        templateUrl: 'scroll.html'
        controller: 'ScrollController'

      $stateProvider.state 'match',
        url: '/match'
        templateUrl: 'match.html'
        controller: 'MatchController'

      $stateProvider.state 'likes',
        url: '/likes'
        templateUrl: 'likes.html'
        controller: 'LikesController'

      $stateProvider.state 'suggestion',
        url: '/suggestion'
        templateUrl: 'suggestion.html'
        controller: 'SuggestionController'

      return
)
