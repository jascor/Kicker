Kicker.ForgotPasswordController = Ember.Controller.extend(
  actions:
    backToLogin: ->
      @transitionToRoute 'login'
)