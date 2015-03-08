Kicker.PopupNotificationsContainerComponent = Ember.Component.extend(Ember.MutableArray,
  layoutName: 'components/popup_notifications_container'

  visibleNotifications: Ember.computed.alias 'notifications'
)