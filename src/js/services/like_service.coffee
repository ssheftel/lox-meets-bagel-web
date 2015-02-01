angular.module(
    'LoxMeetsBagel.services.LikeService', ['LoxMeetsBagel.services.TokenService']
).
factory(
    'LikeService', (APP_CONFIG, $http, TokenService) ->
        #APP_CONFIG.like# = /api/v1.0/like

        likeService = {}
        likeService.likes = []

        likeService.getRaw = ->
          return likeService.likes
        
        #Promise for likes
        likeService.load = (userId) ->
            url = APP_CONFIG.getLikes.replace('{{userId}}', userId)
            $http.get(url)

        #Promise for likes + updates LikeService.likes
        likeService.get = (userId) ->
            likeService.load(userId).then (resp) ->
                likeService.likes = resp.data
                return resp.data

        #Promise for likes + adds a user to the likes + updates likes
        likeService.add = (userId, likeUserId) ->
            url = APP_CONFIG.likeSomeone.replace('{{userId}}', userId).replace('{{likeUserId}}', likeUserId)
            $http.post(url, {}).then (resp) ->
                likeService.likes = resp.data
                return resp.data

        #Promise for likes + removes a like
        likeService.remove = (userId, unlikeUserId) ->
            url = APP_CONFIG.likeSomeone.replace('{{userId}}', userId).replace('{{likeUserId}}', unlikeUserId)
            $http.delete(url).then (resp) ->
                likeService.likes = resp.data
                return resp.data


        likeService
)