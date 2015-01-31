angular.module("LoxMeetsBagel", ['ui.router', "mobile-angular-ui", 'LoxMeetsBagel.services.TokenService', 'LoxMeetsBagel.services.LocalStorageService', 'LoxMeetsBagel.services.AccountService', 'LoxMeetsBagel.services.ProfileService', 'LoxMeetsBagel.services.MatchService', 'LoxMeetsBagel.services.LikeService', "LoxMeetsBagel.controllers.Main", 'LoxMeetsBagel.controllers.Home', 'LoxMeetsBagel.controllers.Login', 'LoxMeetsBagel.controllers.Profile']).constant('APP_CONFIG', {
  like: '/api/v1.0/like',
  match: '/user/uid/match',
  token: '/api/v1.0/token',
  user: '/api/v1.0/user'
}).config(function($httpProvider) {
  var interceptor;
  interceptor = function(APP_CONFIG, $injector, $q, $rootScope) {
    var request, responseError;
    request = function(config) {
      var TokenService, _base;
      TokenService = $injector.get('TokenService');
      if ((_base = config.headers)['Authorization'] == null) {
        _base['Authorization'] = "Basic " + (TokenService.getToken());
      }
      return config;
    };
    responseError = function(rejection) {
      switch (rejection.status) {
        case 401:
          if (rejection.config.url !== APP_CONFIG.token) {
            $rootScope.$broadcast('auth:loginRequired');
            $injector('$state').go('login');
          }
          break;
        case 403:
          $rootScope.$broadcast('auth:forbidden');
          break;
        case 404:
          $rootScope.$broadcast('page:notFound');
          break;
        case 500:
          $rootScope.$broadcast('server:error');
      }
      return $q.reject(rejection);
    };
    return {
      request: request,
      responseError: responseError
    };
  };
  return $httpProvider.interceptors.push(interceptor);
}).config(function($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.otherwise("/home");
  $stateProvider.state('home', {
    url: '/home',
    templateUrl: 'home.html',
    controller: 'HomeController',
    resolve: {
      userId: function(TokenService, $q) {
        return TokenService.getId();
      }
    }
  });
  $stateProvider.state('login', {
    url: '/login',
    templateUrl: 'login.html',
    controller: 'LoginController'
  });
  $stateProvider.state('profile', {
    url: '/profile',
    templateUrl: 'profile.html',
    controller: 'ProfileController'
  });
});
