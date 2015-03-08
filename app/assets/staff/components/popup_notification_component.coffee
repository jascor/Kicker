Kicker.PopupNotificationComponent = Ember.Component.extend(
  layoutName: 'staff/components/popup_notification'

  classNames: ['popupNotification', 'error']

  classNameBindings: ['clickable', 'hasIntent', 'closeable']

  didInsertElement: ->
    @_super()

    self = @

  hasIntent: Ember.computed(->
    if @get 'intent'
      true
    else
      false
  ).property 'intent'

  click: ->
    if @get 'hasIntent'
      @get('intent')()


  actions:
    close: ->

)