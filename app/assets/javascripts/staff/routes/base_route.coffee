Kicker.BaseRoute = Ember.Route.extend(Kicker.Sessions,
  beforeModel: (transition) ->
    sessionObject = @get 'session'

    validateAuth = @validateAuthentication()
    self = @

    @redirectToAuth transition unless validateAuth

    validateAuth.fail (result) ->
      self.redirectToAuth transition

  redirectToAuth: (transition) ->
    @clearExistingSessionData

    loginController = @controllerFor 'login'
    loginController.set 'pausedTransition', transition

    @transitionTo 'login'
)