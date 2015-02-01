angular.module('LoxMeetsBagel.controllers.Scroll', [])
.controller( 'ScrollController', ($scope, $rootScope, uc, participants, LikeService) ->
  $scope.participants = participants
  $scope.scroll = {}
  $scope.scroll.q = ''
  $scope.scroll.likes = uc.getLikes()
  $scope.$watchCollection uc.getLikes, (newLikes, oldLikes, scope) ->
    $scope.scroll.likes = newLikes

  #
  $scope.unlikePerson = (unlikeUserId) ->
    return LikeService.remove(uc.get('id'), unlikeUserId).then (likes) ->
      uc.setLikes(likes)
      return likes

  #
  $scope.likePerson = (likeUserId) ->
    LikeService.add(uc.get('id'), likeUserId).then (likes) ->
      uc.setLikes(likes)
      return likes


  return



)