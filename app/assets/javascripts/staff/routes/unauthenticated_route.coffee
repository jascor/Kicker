###
  Unauthenticated routes are routes that require a user
  to not be currently authenticated. Such routes include
  the registration, log in, and forgotten password pages.
###

Kicker.UnauthenticatedRoute = Ember.Route.extend(Kicker.Sessions,
  beforeModel: (transition) ->
    validateAuth = @validateAuthentication()
    self = @

    if validateAuth
      validateAuth.done (result) ->
        self.transitionTo 'index'

      validateAuth.fail (result) ->
        @clearExistingSessionData()
    else
      @clearExisitingSessionData()
)