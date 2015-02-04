angular.module('LoxMeetsBagel.controllers.Scroll', [])
.controller( 'ScrollController', ($scope, $rootScope, APP_CONFIG, uc, participants, LikeService) ->
  $scope.canShow = (Date.now() >= new Date(APP_CONFIG.startShowingMatches)) || uc.isAdmin()
  $scope.participants = participants
  $scope.scroll = {}
  $scope.scroll.q = ''
  $scope.scroll.likes = uc.getLikes()
  $scope.scroll.suggested_matches = uc.get('suggested_matches')
  $scope.modal1 = false
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

  $scope.testSwipe = ->
    alert('hi')
  return



)