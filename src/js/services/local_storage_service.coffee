angular.module(
  'LoxMeetsBagel.services.LocalStorageService', []
).
factory('LocalStorageService', (APP_CONFIG, $window) ->
  dummyLsDb = {}
  dummyLs = {
    setItem: (k,v) ->
      dummyLsDb[k] = v
      dummyLs
    getItem: (k) ->
      dummyLsDb[k]
    clear: ->
      for own k,v of dummyLsDb
        delete dummyLsDb[k]
      dummyLsDb
  }
  ls = $window.localStorage or dummyLs
  localStorageService = {
  }

  localStorageService.setItem = (k, v) ->
    ls.setItem(k, v)
    localStorageService
  localStorageService.getItem = (k) ->
    ls.getItem(k)
  localStorageService.clear = ->
    ls.clear()
    localStorageService

  return localStorageService

)