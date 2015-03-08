Kicker.DraggableArticleComponent = Ember.Component.extend(Ember.MutableArray, Kicker.DraggableComponent,
  layoutName: 'components/draggable_article'

  classNames: ['article']

  shouldShowSummary: false

  toggleSummaryButtonText: (->
    if @get 'shouldShowSummary'
      'Hide Summary'
    else
      'Show Summary'
  ).property('shouldShowSummary')

  dragStart: (e) ->
    @_super e

    articleData = @get('article')

    e.dataTransfer.setData 'payload', @buildPayload articleData.get('headline'), articleData.get('section').get 'name'

  dragEnd: (e) ->
    @_super e

  click: ->
    @set 'dddd', true

  actions:
    toggleSummary: ->
      @set 'shouldShowSummary', not @get 'shouldShowSummary'
)