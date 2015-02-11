Kicker.ApplicationRoute = Ember.Route.extend(Kicker.Sessions,
  renderTemplate: () ->
    @render 'staff.application'
)