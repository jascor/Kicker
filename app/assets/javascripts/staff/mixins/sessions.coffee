Kicker.Sessions = Ember.Mixin.create(
  authUser: (userData, transition) ->
    if transition is null then transition = false

    userData = @decamelizeArrayKeys userData

    self = @

    $.post('/staff.api.v1/auth/sign_in', userData, (data, textStatus, xhrObject) ->
      headers = self.authHeadersFromXhrObject xhrObject

      self.updateCookies headers
      self.updateSessionObject data.data, headers
      self.setUserAuthenticationStatus true

      if transition
        pausedTransition = @get 'pausedTransition'

        if pausedTransition
          @set 'pausedTransition', null
          pausedTransition.retry()
        else
          @transitionToRoute 'index'
    )

  registerUser: (formData) ->
    formData = @decamelizeArrayKeys formData

    $.post '/staff.api.v1/auth', formData

  validateAuthentication: ->
    headers = @getCurrentAuthHeaderValues()

    return false unless headers

    self = @

    $.ajax(
      type: 'GET'
      url: '/staff.api.v1/auth/validate_token'
      headers: (
        'access-token': headers.accessToken
        uid: headers.uid
        client: headers.client
      )
      success: (data, textStatus, xhrObject) ->
        headers = self.authHeadersFromXhrObject xhrObject

        self.updateCookies headers
        self.updateSessionObject data.data, headers
        self.setUserAuthenticationStatus true
    )

  authHeadersFromXhrObject: (xhrObject) ->
    accessToken = xhrObject.getResponseHeader 'access-token'
    client = xhrObject.getResponseHeader 'client'
    uid = xhrObject.getResponseHeader 'uid'
    daysToExpiration = differenceBetweenSecondsInDays xhrObject.getResponseHeader('expiry'), ((new Date()).getTime() / 1000)

    (
      accessToken: accessToken
      client: client
      uid: uid
      expiration: daysToExpiration
    )

  updateCookies: (headers) ->
    $.cookie 'apiAccessToken', headers.accessToken, (
      expires: headers.expiration
      path: '/'
    )
    $.cookie 'apiUid', headers.uid, (
      expires: headers.expiration
      path: '/'
    )
    $.cookie 'apiClient', headers.client, (
      expires: headers.expiration
      path: '/'
    )

  updateSessionObject: (user, headers) ->
    # @todo May or may not working depending on how Ember injects the session object
    sessionObject = @get 'session'
    sessionObject.set 'currentUser', user
    sessionObject.set 'apiAccessToken', headers.accessToken
    sessionObject.set 'client', headers.client
    sessionObject.set 'uid', headers.uid

  clearExisitingSessionData: ->
    nullHeaderValues = (
      accessToken: null
      client: null
      uid: null
    )

    @updateSessionObject null, nullHeaderValues
    @updateCookies nullHeaderValues
    @setUserAuthenticationStatus false

    return

  getCurrentAuthHeaderValues: ->
    sessionObject = @get 'session'
    sessionData = sessionObject.getProperties ['apiAccessToken', 'client', 'uid']

    for key of sessionData
      unless sessionData[key]
        sessionData = null
        break

    unless sessionData
      sessionData = (
        apiAccessToken: $.cookie 'apiAccessToken'
        uid: $.cookie 'apiUid'
        client: $.cookie 'apiClient'
      )

      for key of sessionData
        unless sessionData[key]
          return null

    (
      accessToken: sessionData.apiAccessToken
      client: sessionData.client
      uid: sessionData.uid
    )

  setUserAuthenticationStatus: (status) ->
    sessionObject = @get 'session'
    sessionObject.set 'isAuthenticated', status

  decamelizeArrayKeys: (arrayHash) ->
    for key of arrayHash
      decamelizedKey = key.decamelize()

      unless decamelizedKey is key
        arrayHash[decamelizedKey] = arrayHash[key]
        delete arrayHash[key]

    arrayHash
)