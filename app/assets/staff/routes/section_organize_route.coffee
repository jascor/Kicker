Kicker.SectionOrganizeRoute = Kicker.BaseRoute.extend(
  model: (params) ->
    @store.find 'section', params.section_id

  afterModel: ->
    @set 'articles', @store.find 'article'

  #renderTemplate: ->
    #@_super()

    #@render 'staff.section.organize'

  setupController: (controller, model) ->
    @_super controller, model

    controller.set 'articles', @get 'articles'
)