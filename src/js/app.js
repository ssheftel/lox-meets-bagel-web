angular.module("LoxMeetsBagel", ["ngRoute", "mobile-angular-ui", "LoxMeetsBagel.controllers.Main", 'LoxMeetsBagel.services.TokenService', 'LoxMeetsBagel.services.MatchService', 'LoxMeetsBagel.services.LikeService']).constant('APP_CONFIG', {
  like: '/api/v1.0/like',
  match: '/api/v1.0/match',
  token: '/api/v1.0/token'
}).config(function($httpProvider) {
  var interceptor;
  interceptor = function($injector) {
    var request;
    request = function(config) {
      var TokenService, _base;
      TokenService = $injector.get('TokenService');
      if ((_base = config.headers)['Authorization'] == null) {
        _base['Authorization'] = TokenService.token + ":unused";
      }
      return config;
    };
    return {
      request: request
    };
  };
  return $httpProvider.interceptors.push(interceptor);
}).config(function($routeProvider) {
  $routeProvider.when("/", {
    templateUrl: "home.html",
    reloadOnSearch: false
  });
});
