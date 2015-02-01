Kicker.ArticleTags = Ember.Mixin.create(
  validateTag: (tag) ->
    ###
    This regular expression validates the following (valid) characters:
      - Alphanumeric characters (+ accented versions)
      - Underscore, Dash
      - Spaces
      - !, @, #, ?, $, %, &, *, +, ;, :, ', ", /, ., ,,
    ###
    validationRegex = /^[a-zA-Z0-9_!@#?$%&*+;:'"/\.,\s\u00C0-\u017F\-]+$/

    validationRegex.test tag
)