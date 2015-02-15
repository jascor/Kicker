Kicker.ForgotPasswordController = Ember.Controller.extend(
  reset: ->
    @setProperties(
      email: null
    )

  actions:
    backToLogin: ->
      @transitionToRoute 'login'
)