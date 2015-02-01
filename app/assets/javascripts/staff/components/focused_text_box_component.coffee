Kicker.FocusedTextBoxComponent = Ember.TextField.extend(
  becomeFocused: (->
    @$().focus()
  ).on 'didInsertElement'

  noFocusOutOnEnter: (->
    self = @
    @$().on 'keydown', (e) ->
      if e.keyCode is 13 or e.keyCode is 27
        self.$().unbind 'focusout'
  ).on 'didInsertElement'

  removeFocusOnEsc: (->
    self = @
    @$().on 'keydown', (e) ->
      if e.keyCode is 27
        self.removeFocusCallback()
  ).on 'didInsertElement'

  removeFocus: (->
    self = @
    @$().on 'focusout', ->
      self.removeFocusCallback()
  ).on 'didInsertElement'

  removeFocusCallback: ->
    @sendAction 'onRemoveFocus'
)