Kicker.UserSerializer = DS.RESTSerializer.extend(
  serialize: (record, options) ->
    json = @_super record, options

    # We have to manually add password and
    # password_confirmation to the JSON
    # because they aren't properties in the
    # User model (for security purposes, obviously).
    password = record.get 'password'
    password_confirmation = record.get 'passwordConfirmation'

    if password then json.password = record.get 'password'
    if password_confirmation then json.password_confirmation = record.get 'passwordConfirmation'

    json
)