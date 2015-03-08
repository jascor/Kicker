Ember.Handlebars.helper 'faIconFromClassName', (icon, options) ->
  attributes = options.hash || {}

  result = '<i class="fa ' +
           icon +
           (if attributes.classNames then ' ' + attributes.classNames else '') +
           '"></i>'

  new Handlebars.SafeString result