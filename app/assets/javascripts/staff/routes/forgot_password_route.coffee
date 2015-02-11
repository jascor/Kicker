Kicker.ForgotPasswordRoute = Kicker.UnauthenticatedRoute.extend(
  beforeModel: ->
    @_super()

  deactivate: ->
    @controller.setProperties(
      email: null
    )

  renderTemplate: ->
    @_super()

    @render 'staff.full_pages.auth.forgot_password'
)