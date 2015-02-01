Kicker.ArticleTagComponent = Ember.Component.extend(Kicker.ArticleTags,
  layoutName: 'staff/components/article_tag'

  classNames: ['articleTag']

  tagName: 'div'

  isEditing: null

  currentTag: null

  init: ->
    @_super()

    @set 'isEditing', false

  actions:
    toggleEditing: ->
      if not @get 'isEditing' then @set 'currentTag', @get 'tag'

      @set 'isEditing', not @get 'isEditing'

    updateTag: ->
      newTag = @get 'tag'

      if newTag.length is 0 or not newTag.trim() then @send 'removeTag'

      unless @validateTag newTag
        @set 'tag', @get 'currentTag'
      else
        @set 'tag', newTag

      @send 'toggleEditing'

    removeTag: ->
      @destroy()
)