Kicker.DraggableZoneComponent = Ember.Component.extend(Kicker.DraggableZone,
  layoutName: 'staff/components/draggable_zone'

  hasArticle: false

  drop: (e) ->
    @set 'headline', e.dataTransfer.getData 'payload'

    @set 'hasArticle', true

    @_super e
)