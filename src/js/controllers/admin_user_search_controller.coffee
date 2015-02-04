#admin_user_search_controller.coffee
angular.module('LoxMeetsBagel.controllers.AdminUserSearchController', [])
.controller 'AdminUserSearch', ($scope, $rootScope, APP_CONFIG, allUsers, $http) ->
  $scope.search = {q: ''}
  $scope.allUsers = allUsers
  $scope.resendInvite = (email) ->
    $http.put(APP_CONFIG.resendInviteEmail, {email:email}).then (resp) ->
      resp.data
      alert("resent email to #{email}")
