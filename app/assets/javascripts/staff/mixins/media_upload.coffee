Kicker.MediaUpload = Ember.Mixin.create(
  afterUpload: (data) ->
    newMedia = @store.createRecord 'medium', data.media
    newMedia.save()
)