Kicker.ApplicationController = Ember.Controller.extend(Kicker.Sessions,
  isAuthenticated: Ember.computed.alias 'session.isAuthenticated'

  unreadNotifications: Ember.computed.alias 'notifications.unseenNotifications'

  isStoreEnabled: store.enabled
)