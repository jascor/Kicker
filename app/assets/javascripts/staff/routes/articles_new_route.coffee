Kicker.ArticlesNewRoute = Kicker.BaseRoute.extend(
  beforeModel: (transition) ->
    @_super transition

  model: ->
    Ember.RSVP.hash (
      sections: @store.find 'section'
      media: @store.find 'medium'
    )

  renderTemplate: ->
    @render 'staff.articles.new'

  setupController: (controller, model) ->
    @_super controller, model
)