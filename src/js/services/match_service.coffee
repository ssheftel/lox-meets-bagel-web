angular.module(
    'LoxMeetsBagel.services.MatchService', []
).
factory(
    'MatchService', (APP_CONFIG, $http) ->
        #APP_CONFIG.match# = /api/v1.0/match

        matchService = {}
        matchService.matches = {}
        
        #Promise for matches
        matchService.load = -> $http.get(matchService.matches)

        #Promise for matches + updates MatchService.matches
        matchService.get = ->
            matchService.load().then (resp) ->
                matchService.matches = resp.data
                return resp.data

        matchService
)