Kicker.Notification = Ember.Mixin.create(
  invokeNotification: (title, message) ->
    Kicker.PopupNotificationComponent.create(
      title: title
      contents: message
    ).append()
)