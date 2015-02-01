angular.module('LoxMeetsBagel.controllers.Scroll', [])
.controller( 'ScrollController', ($scope, APP_CONFIG, $rootScope, TokenService, AccountService, LikeService, info, participants) ->
  $scope.participants = participants
  $scope.searchText = {q: ''}
  $scope.selected = {}
  $scope.selected.likes = LikeService.likes

  $scope.thumbImage = (userObj) ->
    if userObj.photo_name
      imgurl = APP_CONFIG.thumbUrl.replace('{{userId}}', userObj.photo_name)
    else
      imgurl = APP_CONFIG.thumbUrl.replace('{{userId}}', APP_CONFIG.defaultFace)
    return imgurl


  $scope.$watchCollection LikeService.getRaw, (newVal) ->
    $scope.selected.likes = newVal

  #
  $scope.unlikePerson = (unlikeUserId) ->
    userId = TokenService.getId()
    LikeService.remove(userId, unlikeUserId)
  #
  $scope.likePerson = (likeUserId) ->
    userId = TokenService.getId()
    LikeService.add(userId, likeUserId)


  return



)