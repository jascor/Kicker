#= require jquery
#= require jquery.cookie
#= require handlebars
#= require ember
#= require ember-data
#= require_directory ./polyfills
#= require ./libraries/i18n
#= require_directory ./libraries
#= require ./custom/jquery_ajax_csrf_header
#= require ./custom/string_format
#= require_tree ./custom/redactor_plugins
#= require_tree ./custom
#= require_self
#= require ./kicker

# for more details see: http://emberjs.com/guides/application/
window.Kicker = Ember.Application.create(
  env: Em.Object.create()

  ready: ->
    @register 'session:current', Kicker.Session, singleton: true
    @inject 'controller', 'session', 'session:current'
    @inject 'route', 'session', 'session:current'

    @register 'notifications:global', Kicker.Notifications, singleton: true
    @inject 'controller', 'notifications', 'notifications:global'

  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
)

Kicker.Router.reopen(
  location: 'history'
)