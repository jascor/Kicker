Kicker.RegisterRoute = Kicker.UnauthenticatedRoute.extend(
  beforeModel: ->
    @_super()

  init: ->

  renderTemplate: ->
    @_super()

    @render 'staff.full_pages.auth.register'

  setupController: (controller, context) ->
    controller.reset()

  actions:
    willTransition: (transition) ->
)