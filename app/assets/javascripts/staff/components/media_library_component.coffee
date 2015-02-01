Kicker.MediaLibraryComponent = Ember.Component.extend(
  layoutName: 'staff/components/media_library'

  classNames: ['mediaLibraryContainer']

  actions:
    initFilepicker: ->
      self = @

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
          'FLICKR'
        ]
        openTo: 'COMPUTER'
      ,
        location: 'S3'
        path: '/uploads/kicker_image/image/'
        access: 'public'
      ,
        (blobs) ->
          i = 0
          while i < blobs.length
            data = (
              media:
                filename: blobs[i].filename
                mimeType: blobs[i].mimetype
                S3Key: blobs[i].key
                link: blobs[i].url
            )

            self.sendAction 'onMediaUpload', data
            i++
      ,
        (error) ->
          console.log error
      )

    close: ->
      @sendAction 'onLibraryClose'
)