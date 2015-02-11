Kicker.RegisterRoute = Kicker.UnauthenticatedRoute.extend(
  beforeModel: ->
    @_super()

  deactivate: ->
    @controller.setProperties(
      email: null
      firstName: null
      lastName: null
      password: null
      passwordConfirmation: null
    )

  init: ->

  renderTemplate: ->
    @_super()

    @render 'staff.full_pages.auth.register'

  actions:
    willTransition: (transition) ->
)