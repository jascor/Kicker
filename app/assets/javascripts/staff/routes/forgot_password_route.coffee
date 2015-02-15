Kicker.ForgotPasswordRoute = Kicker.UnauthenticatedRoute.extend(
  beforeModel: ->
    @_super()

  renderTemplate: ->
    @_super()

    @render 'staff.full_pages.auth.forgot_password'

  setupController: (controller, context) ->
    controller.reset()
)