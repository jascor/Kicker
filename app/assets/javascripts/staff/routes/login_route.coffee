Kicker.LoginRoute = Kicker.UnauthenticatedRoute.extend(
  beforeModel: ->
    @_super()

  renderTemplate: ->
    @render 'staff.full_pages.auth.login'

  setupController: (controller, context) ->
    controller.reset()
)