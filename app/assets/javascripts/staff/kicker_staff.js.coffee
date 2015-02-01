#= require jquery
#= require jquery.cookie
#= require handlebars
#= require ember
#= require ember-data
#= require_directory ./libraries
#= require ./custom/string_format
#= require_tree ./custom/redactor_plugins
#= require_self
#= require ./kicker

# for more details see: http://emberjs.com/guides/application/
window.Kicker = Ember.Application.create(
  env: Em.Object.create()
)

Kicker.Router.reopen(
  location: 'history'
)