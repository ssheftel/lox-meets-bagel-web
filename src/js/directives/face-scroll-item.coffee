#face-scroll-item.coffee
###
  <face-scroll-item person=persons[$index]></faceScrollItem>
###
angular.module('LoxMeetsBagel.directives.FaceScrollItem', []).
controller( 'FaceScrollItemController', ($scope) ->
).
directive 'faceScrollItem', (UserContextService, PhotoService, LikeService, $document) ->
  cfg = {}
  linkFn = (scope, element, attrs, controller) ->
    #scope.person
    scope.thumbUrl = PhotoService.thumbnailUrl(scope.person.photo_name)

    scope.likeState = 0
    scope.unlikePerson = ->
    return LikeService.remove(UserContextService.get('id'), scope.person.id).then (likes) ->
      UserContextService.setLikes(likes)
      return likes

    #
    scope.likePerson = ->
      LikeService.add(UserContextService.get('id'), scope.person.id).then (likes) ->
        UserContextService.setLikes(likes)
        return likes


  cfg.restrict = 'AE'
  cfg.replace = true
  cfg.templateUrl = 'face_scroll_item_tpl.html'
  #cfg.require = 'faceScrollArea'
  cfg.scope = {
    person: '='

  }
  cfg.link = linkFn
  return cfg