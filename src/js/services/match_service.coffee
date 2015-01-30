angular.module(
    'LoxMeetsBagel.services.MatchService', []
).
factory(
    'MatchService', (APP_CONFIG, $http) ->
        #APP_CONFIG.match# = /api/v1.0/match

        matchService = {}
        matchService.matches = {}


        #Promise for matches
        matchService.load = (userId) -> $http.get(APP_CONFIG.match.replace('uid',userId))

        #Promise for matches + updates MatchService.matches
        matchService.get = (userId=TokenService.getId()) ->
            matchService.load(userId).then (resp) ->
                matchService.matches = resp.data
                return resp.data

        matchService
)