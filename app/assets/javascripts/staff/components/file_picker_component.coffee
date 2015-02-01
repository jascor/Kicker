Kicker.FilePickerComponent = Ember.Component.extend(
  init: ->
    @_super()

  didInsertElement: ->
    @_super()

    filepicker.setKey Kicker.get 'env.filepickerAPIKey'

    filepicker.pickAndStore(
      multiple: true
      mimetype: ['image/*']
      language: 'en'
      services: [
        'COMPUTER',
        'DROPBOX',
        'FACEBOOK',
        'GMAIL',
        'GOOGLE_DRIVE',
        'SKYDRIVE',
        'URL',
        'INSTAGRAM',
        'FLICKR',
      ]
      openTo: 'COMPUTER'
      #debug: true
    ,
      location: 'S3'
      path: '/uploads/kicker_image/image/'
      access: 'public'
    ,
      (blobs) ->
        console.log blobs
    ,
      (error) ->
        console.log error
    )
)