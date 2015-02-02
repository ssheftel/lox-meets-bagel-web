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
factory 'UserContextService', (APP_CONFIG, $http, $q, LocalStorageService) ->
  userContext = {}
  userContext._context = {}
  userContext._defer = $q.defer()
  userContext.promise = userContext._defer.promise

  userContext.loadContext = ->
    userContext._defer = $q.defer() # rest to new defered
    userContext.promise = userContext._defer.promise # reset promise
    return $http.get(APP_CONFIG.context).then (resp) ->
      userContext._context = resp.data
      userContext.setToken(resp.data.token) if resp.data.token
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
      userContext.setToken(resp.data.token) if resp.data.token
      userContext._defer.resolve(userContext)
      return userContext.promise

  userContext.getId = ->
    return userContext.get('id')
  userContext.getToken = ->
    return userContext.get('token') or LocalStorageService.getItem('token')

  userContext.setToken = (token) ->
    userContext.set('token', token)
    LocalStorageService.setItem('token', token)
    return

  userContext.deleteToken = ->
    userContext.setToken('')
    LocalStorageService.removeItem('token')
    userContext._defer = $q.defer() # reset promise
    userContext.promise = userContext._defer.promise # reset promise
    return

  userContext.getLikes = ->
    return userContext.get('likes')


  userContext.appendLike = (like) ->
    like = 0 + like if !isNaN(like)
    _likes = userContext.getLikes()
    if like and like not in _likes
      _likes.push(like)
    return

  userContext.isUserIdInLikes = (userId) ->
    userId = 0 + userId if !isNaN(userId)
    _likes = userContext.getLikes()
    return userId and userId in _likes



  userContext.setLikes = (likes) ->
    return userContext.set('likes', likes)


  userContext.isAdmin = ->
    return userContext.get('admin') or false

  #to run on logout
  userContext.clearContext = ->
    userContext.deleteToken()
    userContext.set('admin', false)
    return




  #start loading context on injection
  userContext.loadContext()

  return userContext

