Kicker.ArticlesNewRoute = Kicker.BaseRoute.extend(
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