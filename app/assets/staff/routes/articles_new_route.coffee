Kicker.ArticlesNewRoute = Kicker.BaseRoute.extend(
  init: ->
    @_super()

  beforeModel: (transition) ->
    @_super()

  model: ->
    Ember.RSVP.hash (
      sections: @store.find 'section'
      media: @store.find 'medium'
      types: @store.find 'articleType'
    )

  renderTemplate: ->
    @_super()

  setupController: (controller, model) ->
    @_super controller, model
)