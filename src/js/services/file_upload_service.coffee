angular.module(
  'LoxMeetsBagel.services.FileUploadService', []
).directive('fileModel',
  ($parse) ->
    {
    restrict: 'A'
    link: (scope, element, attrs) ->
      model = $parse(attrs.fileModel)
      modelSetter = model.assign
      element.bind 'change', ->
        scope.$apply ->
          modelSetter scope, element[0].files[0]
          return
        return
      return

    }
).service 'FileUploadService', ($http) ->

  @uploadFileToUrl = (file, uploadUrl) ->
    fd = new FormData
    fd.append 'file', file
    return $http.post(uploadUrl, fd,
      transformRequest: angular.identity
      headers: 'Content-Type': `undefined`)

  return