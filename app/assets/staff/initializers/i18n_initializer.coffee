Ember.Application.initializer(
  name: 'i18nTranslationLoader'

  initialize: (container, application) ->
    Ember.I18n.locale = 'en'

    Ember.I18n.translations =
      'test': 'dfgdfg'

    return
)