Ember.Handlebars.helper 'includeImage', (imageSrc, altText, options) ->
  attributes = options.hash || {}

  result = '<img src="' +
           imageSrc +
           '" alt="' +
           altText +
           '"' +
           (if attributes.classNames then (' class="' + attributes.classNames + '"') else '') +
           '>'
  new Handlebars.SafeString result