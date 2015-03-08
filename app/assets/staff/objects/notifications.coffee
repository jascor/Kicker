Kicker.Notifications = Ember.Object.extend(Ember.MutableArray,
  unseenNotifications: []

  seenNotifications: []

  init: ->
    self = @
    ###
    setTimeout(->
      self.addNotification (
        title: 'TESTING ANOTHER NOTIFICATION'
        message: 'ANOTHER NOTIFICATION MESSAGE'
        clickable: true
        intent: null
        dismissAfter: null
      )
    , 5000)
    ###

  addNotification: (notificationObject) ->
    @get('unseenNotifications').addObject notificationObject
)