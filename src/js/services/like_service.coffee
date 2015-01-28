angular.module(
    'LoxMeetsBagel.services.LikeService', []
).
factory(
    'LikeService', (APP_CONFIG, $http) ->
        #APP_CONFIG.like# = /api/v1.0/like

        likeService = {}
        likeService.likes = []
        
        #Promise for likes
        likeService.load = -> $http.get(APP_CONFIG.like)

        #Promise for likes + updates LikeService.likes
        likeService.get = ->
            likeService.load().then (resp) ->
                likeService.likes = resp.data
                return resp.data

        #Promise for likes + adds a user to the likes + updates likes
        likeService.add = (userId) ->
            $http.post("#{APP_CONFIG.like}/#{userId}").then (resp) ->
                likeService.likes = resp.data
                return resp.data

        #Promise for likes + removes a like
        likeService.remove = (userId) ->
            $http.delete("#{APP_CONFIG.like}/#{userId}").then (resp) ->
                likeService.likes = resp.data
                return resp.data


        likeService
)