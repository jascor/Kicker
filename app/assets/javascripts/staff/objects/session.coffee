Kicker.Session = Ember.Object.extend(
  apiAccessToken: null

  currentUser: null

  client: null

  uid: null

  isAuthenticated: null

  lastAuthenticated: null

  expires: null

  init: ->
    @_super()

  authenticationStatusChanged: (->
    if @get 'isAuthenticated'
      @set 'lastAuthenticated', (new Date()).getTime() / 1000
    else
      @set 'lastAuthenticated', null
  ).observes('isAuthenticated').on 'init'
)