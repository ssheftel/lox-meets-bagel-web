angular.module('LoxMeetsBagel.controllers.Suggestion', [])
.controller( 'SuggestionController', ($scope, uc, participants, LikeService) ->
  $scope.suggested_matches = uc.get('suggested_matches')
  $scope.participants = participants


  return

)
