Kicker.LoginRoute = Kicker.UnauthenticatedRoute.extend(
  beforeModel: ->
    @_super()

  deactivate: ->
    @controller.setProperties(
      email: null
      password: null
    )

  renderTemplate: ->
    @render 'staff.full_pages.auth.login'
)