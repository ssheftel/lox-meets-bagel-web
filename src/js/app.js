angular.module("LoxMeetsBagel", ["ngRoute", "mobile-angular-ui", "LoxMeetsBagel.controllers.Main", 'LoxMeetsBagel.services.TokenService', 'LoxMeetsBagel.services.AccountService', 'LoxMeetsBagel.services.MatchService', 'LoxMeetsBagel.services.LikeService', 'LoxMeetsBagel.controllers.Home', 'LoxMeetsBagel.controllers.Login']).constant('APP_CONFIG', {
  like: '/api/v1.0/like',
  match: '/user/uid/match',
  token: '/api/v1.0/token',
  user: '/api/v1.0/user'
}).config(function($httpProvider) {
  var interceptor;
  interceptor = function(APP_CONFIG, $injector, $q, $rootScope, $location) {
    var request, response, responseError;
    request = function(config) {
      var TokenService, _base;
      TokenService = $injector.get('TokenService');
      if ((_base = config.headers)['Authorization'] == null) {
        _base['Authorization'] = "Basic " + TokenService.token;
      }
      return config;
    };
    response = function(resp) {
      if (resp.config.url === APP_CONFIG.token) {
        $injector.get('TokenService').token = resp.data.token;
        $injector.get('AccountService').id = resp.data.id;
      }
      return resp || $q.when(resp);
    };
    responseError = function(rejection) {
      switch (rejection.status) {
        case 401:
          if (rejection.config.url !== APP_CONFIG.token) {
            $rootScope.$broadcast('auth:loginRequired');
            $location.path('/login');
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
      response: response,
      responseError: responseError
    };
  };
  return $httpProvider.interceptors.push(interceptor);
}).config(function($routeProvider) {
  $routeProvider.when("/home", {
    templateUrl: "home.html",
    controller: 'HomeController',
    resolve: {
      userId: function(TokenService) {
        return TokenService.getId();
      },
      accountService: 10
    }
  });
  $routeProvider.when('/login', {
    templateUrl: 'login.html',
    controller: 'LoginController'
  });
  $routeProvider.otherwise({
    redirectTo: '/home'
  });
});
