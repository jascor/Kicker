Kicker.NoticeBannerComponent = Ember.Component.extend(
  classNames: ['noticeBanner']

  layoutName: 'staff/components/notice_banner'

  removeAfterXSeconds: (->
    removalTime = @get 'removeAfter'

    if removalTime
      self = @

      console.log removalTime * 100
      setTimeout(->
        self.destroy()
      , removalTime * 1000)
  ).on 'didInsertElement'
)