Kicker.SectionOrganizeRoute = Ember.Route.extend(
  model: (params) ->
    @store.find 'section', params.section_id

  renderTemplate: ->
    @render 'staff.section.organize'

  setupController: (controller, model) ->
    @_super controller, model
)