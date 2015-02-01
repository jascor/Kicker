Kicker.RedactorEditorComponent = Ember.Component.extend(
  tagName: 'textarea'

  init: ->
    @_super()

  _updateElementValue: Ember.observer(->
    value = Ember.get @, 'value'
    $el = @$()

    if $el and value and value isnt $el.redactor('code.get')
      $el.redactor 'code.set', value
  , 'value')

  _elementValueDidChange: ->
    Ember.set @, 'value', @$().redactor('code.get')

  didInsertElement: ->
    @_super()

    self = @
    @$().redactor(
      changeCallback: ->
        self._elementValueDidChange()

      plugins: ['advanced', 'createQuote']
    )

    @_updateElementValue()
)