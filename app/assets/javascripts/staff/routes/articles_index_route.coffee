Kicker.ArticlesIndexRoute = Kicker.BaseRoute.extend(
  model: () ->
    #@store.find('article')
    [{
      headline: 'Dario Raschio: Homegrown Portlander, WWII Veteran, Retired FHS Teacher',
      created_by: 'Jason Chen',
      writer: 'Jason Chen',
      section: 'News',
      tags: 'heksdfsdf',
      created_at: '2014-12-25'
    }, {
      headline: 'Dario Raschio: Homegrown Portlander, WWII Veteran, Retired FHS Teacher',
      created_by: 'Jason Chen',
      writer: 'Jason Chen',
      section: 'News',
      tags: 'heksdfsdf',
      created_at: '2014-12-25'
    }, {
      headline: 'Dario Raschio: Homegrown Portlander, WWII Veteran, Retired FHS Teacher',
      created_by: 'Jason Chen',
      writer: 'Jason Chen',
      section: 'News',
      tags: 'heksdfsdf',
      created_at: '2014-12-25'
    }, {
      headline: 'Dario Raschio: Homegrown Portlander, WWII Veteran, Retired FHS Teacher',
      created_by: 'Jason Chen',
      writer: 'Jason Chen',
      section: 'News',
      tags: 'heksdfsdf',
      created_at: '2014-12-25'
    }, {
      headline: 'Dario Raschio: Homegrown Portlander, WWII Veteran, Retired FHS Teacher',
      created_by: 'Jason Chen',
      writer: 'Jason Chen',
      section: 'News',
      tags: 'heksdfsdf',
      created_at: '2014-12-25'
    }]

  setupController: (controller, model) ->
    controller.set 'model', model

  renderTemplate: () ->
    @_super()

    @render 'staff.articles.index'
)