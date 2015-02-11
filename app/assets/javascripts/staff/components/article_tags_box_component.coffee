Kicker.ArticleTagsBoxComponent = Ember.Component.extend(Kicker.ArticleTags,
  layoutName: 'staff/components/article_tags_box'

  tags: null

  init: ->
    @_super()

    @set 'tags', []

  didInsertElement: ->
    @_super()

  actions:
    addTag: ->
      tag = @get('tagName').trim()

      if not tag or tag.length is 0 or not @validateTag tag
        @set 'errorNotice', 'A tag may not be empty and can only contain alphanumeric and the following special characters: !, @, #, ?, $%&*+;:\'"/.,.'
        return false

      @$('> input').focus()

      @get('tags').pushObject tag

      @set 'tagName', ''
)