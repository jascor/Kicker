Kicker.RegisterController = Ember.Controller.extend(Kicker.Sessions, Kicker.Notify,
  init: ->
    self = @
    setTimeout(->
      console.log 'fuck'
      console.log self.get 'actions'
    , 2000)

  reset: ->
    @setProperties(
      email: null
      firstName: null
      lastName: null
      password: null
      passwordConfirmation: null
    )

  actions:
    signUp: ->
      if not @get 'email' then @set 'email', ''
      userInfo = @getProperties ['email', 'firstName', 'lastName', 'password', 'passwordConfirmation']

      self = @

      createUser = @registerUser userInfo

      createUser.done (result) ->
        userCreds = (
          email: userInfo.email
          password: userInfo.password
        )

        signUserIn = self.authUser userCreds

        signUserIn.done (result) ->
          self.transitionToRoute 'index'

        signUserIn.fail (result) ->
          # This should never happen, but we need to handle
          # it in case something unexpected occurs.
          console.log result

      createUser.fail (result) ->
        # Handle user creation failure
        console.log result

    goToLogin: ->
      @transitionToRoute 'login'
)