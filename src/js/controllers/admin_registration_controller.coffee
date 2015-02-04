angular.module('LoxMeetsBagel.controllers.AdminRegistrationController', [])
.controller 'AdminRegistration', ($scope, $rootScope, $http, APP_CONFIG) ->
  $scope.last_user_created = null
  #$scope.first_name = ''
  #$scope.last_name = ''
  #$scope.email = ''
  #$scope.gender = 'F'
  $scope.age = 27 # default cause not tracking so no form feild
  $scope.validate = ->
    return ($scope.first_name and $scope.last_name) and ($scope.email and $scope.gender) and ($scope.age)
  $scope.create_user = ->
    payload = {first_name:$scope.first_name, last_name:$scope.last_name, email:$scope.email, gender:$scope.gender, age:$scope.age}
    $http.post(APP_CONFIG.user, payload).then (resp) ->
      $scope.last_user_created = resp.data
      # Clear out form
      $scope.first_name = ''
      $scope.last_name = ''
      $scope.email = ''
      $scope.gender = 'F'
      $scope.age = 27
      return
  return
