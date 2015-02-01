angular.module(
  'LoxMeetsBagel.services.LocalStorageService', []
).
factory('LocalStorageService', (APP_CONFIG, $window) ->
  dummyLsDb = {}
  dummyLs = {
    setItem: (k,v) ->
      dummyLsDb[k] = v
      return
    getItem: (k) ->
      dummyLsDb[k]
    removeItem: (k) ->
      delete dummyLsDb[k]
      return
    clear: ->
      for own k,v of dummyLsDb
        delete dummyLsDb[k]
      return
  }
  ls = $window.localStorage or dummyLs
  localStorageService = {
  }
  localStorageService.ls = ls

  localStorageService.setItem = (k, v) ->
    ls.setItem(k, v)
    return
  localStorageService.getItem = (k) ->
    ls.getItem(k)
  localStorageService.removeItem = (k) ->
    ls.removeItem(k)
    return
  localStorageService.clear = ->
    ls.clear()
    return

  return localStorageService

)