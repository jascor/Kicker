Kicker.DraggableContentBlockZoneComponent = Ember.Component.extend(Kicker.DraggableZone,
  layoutName: 'components/draggable_content_block_zone'

  hasContent: false

  drop: (e) ->
    data = JSON.parse e.dataTransfer.getData 'payload'

    @set 'currentContent', data
    @set 'hasContent', true
)