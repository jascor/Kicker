Ember.Application.initializer(
  name: 'config'

  initialize: (container, application) ->
    if application.get('env') is `undefined`
      throw new Ember.Error "The Application object must contain an 'env' variable which is assigned as Em.Object.create()."

    EnvReader = EnvReader = ->
      @readEnvKeys = ->
        metaTags = $('meta')
        envVars  = {}

        for i in [0..metaTags.length] by 1
          envKey   = $(metaTags[i]).attr 'name'
          envValue = $(metaTags[i]).attr 'value'

          if /^env\-/.test envKey
            propertyName = Em.String.camelize envKey.substring 4

            envVars[propertyName] = @_mapType envValue

        envVars

      @_mapType = (val) ->
        (if "" is val then null else (if "true" is val then true else (if "false" is val then false else (-1 isnt val.indexOf(",") and (val = val.split(","))
        val
        ))))

      return

    envReader = new EnvReader()
    application.get('env').setProperties envReader.readEnvKeys()
)