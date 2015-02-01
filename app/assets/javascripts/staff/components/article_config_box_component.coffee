Kicker.ArticleConfigBoxComponent = Ember.Component.extend(
  tagName: 'div'

  layoutName: 'staff/components/article_config_box'

  classNames: ['articleConfigEmberComponent']

  init: ->
    @_super()

  actions:
    expandCollapseBox: ->
      $el = @$()

      if $el.hasClass 'expanded'
        $el.removeClass 'expanded'
      else
        $el.addClass 'expanded'
)