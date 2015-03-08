Kicker.Notify = Ember.Mixin.create(
  invokeNotification: (notificationObject) ->
    @get('notifications').addNotification notificationObject
)