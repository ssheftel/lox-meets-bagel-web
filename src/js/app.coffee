angular.module("LoxMeetsBagel", [
  'ui.router'
  "mobile-angular-ui"
  "angular.filter"
  'mobile-angular-ui.gestures'
  #ME
  'LoxMeetsBagel.services.UserContextService'
  'LoxMeetsBagel.services.LocalStorageService'
  'LoxMeetsBagel.services.TokenService'
  'LoxMeetsBagel.services.ParticipantService'
  'LoxMeetsBagel.services.AccountService'
  'LoxMeetsBagel.services.FileUploadService'
  'LoxMeetsBagel.services.ProfileService'
  'LoxMeetsBagel.services.PhotoService'
  'LoxMeetsBagel.services.MatchService'
  'LoxMeetsBagel.services.LikeService'

  'LoxMeetsBagel.controllers.Sidebar'
  "LoxMeetsBagel.controllers.Main"
  'LoxMeetsBagel.controllers.Home'
  'LoxMeetsBagel.controllers.Login'
  'LoxMeetsBagel.controllers.Profile'
  'LoxMeetsBagel.controllers.Scroll'
  'LoxMeetsBagel.controllers.Match'
  'LoxMeetsBagel.controllers.Likes'
  'LoxMeetsBagel.controllers.Suggestion'
  'LoxMeetsBagel.controllers.AdminController'
  'LoxMeetsBagel.controllers.AdminAppConfigController'
  'LoxMeetsBagel.controllers.AdminRegistrationController'
  'LoxMeetsBagel.controllers.AdminUserSearchController'
])
.constant( 'APP_CONFIG',
    #APP_CONFIG
    like: '/api/v1.0/like'
    match: '/user/uid/match'
    token: '/api/v1.0/token'
    user: '/api/v1.0/user'
    context: '/api/v1.0/context' # new master info endpoint
    getLikes: '/api/v1.0/user/{{userId}}/like'
    uploadPhoto: '/api/v1.0/user/{{userId}}/photo'
    likeSomeone: '/api/v1.0/user/{{userId}}/like/{{likeUserId}}'
    photoUrl: 'http://res.cloudinary.com/lox-meets-bagel/image/upload/v1422675531/{{userId}}.jpg'
    thumbUrl: 'http://res.cloudinary.com/lox-meets-bagel/image/upload/w_150,c_scale,c_thumb,g_face/{{userId}}.jpg'
    defaultFace: 'default_face'
)
.config(
    #Add Auth Headers
    ($httpProvider) ->
        interceptor = (APP_CONFIG, $injector, $q, $rootScope) ->
            request = (config) ->
                #TokenService = $injector.get('TokenService')
                UserContextService = $injector.get('UserContextService')
                #config.headers['Authorization'] ?= "Basic #{TokenService.getToken()}"
                #config.headers['TOKEN'] ?= "#{TokenService.getToken()}"
                config.headers['TOKEN'] ?= "#{UserContextService.getToken()}"
                return config

            response = (resp) ->
              return resp
            responseError = (rejection) ->
              switch rejection.status
                when 401
                  $rootScope.$broadcast('auth:loginRequired')
                  $state = $injector.get('$state')
                  if $state.current.name != 'login'
                    $state.go('login')
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
          uc: (UserContextService) -> UserContextService.promise
          #userId: (TokenService) -> TokenService.load()

      $stateProvider.state 'login',
        url: '/login'
        templateUrl: 'login.html'
        controller: 'LoginController'

      $stateProvider.state 'profile',
        url: '/profile'
        templateUrl: 'profile.html'
        controller: 'ProfileController'
        resolve:
          #userId: (TokenService) ->
          #  return TokenService.load()
          #info: (userId, TokenService,AccountService) ->
          #  `debugger`
          #  return AccountService.getAccountInfo(userId.id)
          uc: (UserContextService) -> UserContextService.promise

      $stateProvider.state 'scroll',
        url: '/scroll'
        templateUrl: 'scroll.html'
        controller: 'ScrollController'
        resolve:
          uc: (UserContextService) -> UserContextService.promise
          #info: (TokenService, AccountService) ->
          #  AccountService.getAccountInfo(TokenService.getId())
          participants: (uc, ParticipantService) ->
            ParticipantService.load(uc.get('attracted_to'))
          #likes: (TokenService, LikeService) -> LikeService.get(TokenService.getId())


      $stateProvider.state 'match',
        url: '/match'
        templateUrl: 'match.html'
        controller: 'MatchController'
        resolve:
          userId: (TokenService) ->
            return TokenService.load()
          info: (userId, TokenService,AccountService) ->
            return AccountService.getAccountInfo(TokenService.getId())

      $stateProvider.state 'likes',
        url: '/likes'
        templateUrl: 'likes.html'
        controller: 'LikesController'
        resolve:
          userId: (TokenService) -> TokenService.load()

      $stateProvider.state 'suggestion',
        url: '/suggestion'
        templateUrl: 'suggestion.html'
        controller: 'SuggestionController'
        resolve:
          userId: (TokenService) -> TokenService.load()

      # admin root state
      $stateProvider.state 'admin',
        url: '/admin'
        templateUrl: 'admin.html'
        controller: 'Admin'
        resolve:
          uc: (UserContextService) -> UserContextService.promise

      $stateProvider.state 'admin.app_config',
        url: '/app_config',
        templateUrl: 'admin_app_config.html'
        controller: 'AdminAppConfig'

      $stateProvider.state 'admin.registration',
        url: '/admin_registration'
        templateUrl: 'admin_registration.html'
        controller: 'AdminRegistration'

      $stateProvider.state 'admin.user_search',
        url: '/user_search',
        templateUrl: 'admin_user_search.html'
        controller: 'AdminUserSearch'

      return
)
