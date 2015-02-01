###
  second attempt at an account service - will combine function of old token service and

  UserContext.promise -> promise for context resolves to the value of the service
  UserContext.get('') -> returns the value of a context item
  UserContext.set('', '') -> sets the value of a context item
  UserContext.loadContext() -> null but it creates a new promise for the context
  UserContext.login(email, password) -> resolves to the context

  APP_CONFIG.context
###
angular.module('LoxMeetsBagel.services.UserContextService', []).
factory 'UserContextService', (APP_CONFIG, $http, $q) ->
  userContext = {}
  userContext._context = {}
  userContext._defer = $q.defer()
  userContext.promise = userContext._defer.promise

  userContext.loadContext = ->
    userContext._defer = $q.defer() # rest to new defered
    userContext.promise = userContext._defer.promise # reset promise
    return $http.get(APP_CONFIG.context).then (resp) ->
      userContext._context = resp.data
      userContext._defer.resolve(userContext)
      return userContext.promise


  userContext.get = (key) ->
    return userContext._context[key]

  userContext.set = (key, value) ->
    return userContext._context[key] = value

  userContext.login = (email, password) ->
    userContext._defer = $q.defer() # rest to new defered
    userContext.promise = userContext._defer.promise # reset promise
    return $http.post(APP_CONFIG.context, {email, password}, headers: {'TOKEN': "#{email}:#{password}"}).then (resp) ->
      userContext._context = resp.data
      userContext._defer.resolve(userContext)
      return userContext.promise


  #start loading context on injection
  userContext.loadContext()

  return userContext

