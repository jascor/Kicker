Kicker.ArticlesNewController = Ember.ObjectController.extend(Ember.Evented, Kicker.MediaUpload,
  submittingNewObject: false

  messages: ['dfgdfg', 'dfgdfg', 'dfgdfg', 'dfgsdgsdfg', 'sdfgsdgsdfg', 'sdfgsdgsdfg']

  tags: []

  init: ->
    @_super()

  actions:
    saveArticle: ->
      @set 'submittingNewObject', true

      article = @store.createRecord 'article',
        headline: @get 'headline'
        subheading: @get 'subheading'
        rawWriterName: @get 'rawWriterName'
        rawContents: @get 'rawContents'
        disableComments: @get 'disableComments'
      article.save()

    addTag: ->
      @get('tags').push @get 'tag'

    mediaUpload: (data) ->
      @afterUpload data

    testSubmitA: ->
      @set 'submittingNewObject', true

      @send 'saveArticle'

    testML: ->
      @set 'isMediaLibraryOpen', !@get 'isMediaLibraryOpen'
)