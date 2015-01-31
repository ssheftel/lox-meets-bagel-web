angular.module(
    'LoxMeetsBagel.services.MatchService', ['LoxMeetsBagel.services.TokenService']
).
factory(
    'MatchService', (APP_CONFIG, $http, TokenService) ->
        #APP_CONFIG.match# = /api/v1.0/match

        matchService = {}
        matchService.matches = {}


        #Promise for matches
        matchService.load = (userId) -> $http.get(APP_CONFIG.match.replace('uid',userId))

        #Promise for matches + updates MatchService.matches
        matchService.get = (userId=TokenService.getId()) ->
            return matchService.load(userId).then (resp) ->
                matchService.matches = resp.data
                return resp.data

        matchService
)