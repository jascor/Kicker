Kicker.LoginController = Ember.Controller.extend(Kicker.Sessions,
  isLoggingIn: false

  init: ->

  reset: ->
    @setProperties(
      email: null
      password: null
    )

  actions:
    signIn: ->
      @set 'isLoggingIn', true
      ###
      if not @get 'email' then @set 'email', ''
      data = @getProperties ['email', 'password']

      authenticate = @authUser data
      self = @

      authenticate.done (data, textStatus, xhrObject) ->
        pausedTransition = self.get 'pausedTransition'

        if pausedTransition
          self.set 'pausedTransition', null
          pausedTransition.retry()
        else
          self.transitionToRoute 'index'

      authenticate.fail (data, textStatus, xhrObject) ->
        # Handle sign-in errors somehow...
        console.log data
      ###

    forgotPassword: ->
      @transitionToRoute 'forgotPassword'

    registerAccount: ->
      @transitionToRoute 'register'
)