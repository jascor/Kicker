Kicker.DraggableItemComponent = Ember.Component.extend(
  layoutName: 'staff/components/draggable_item'

  classNames: ['draggableItem']

  attributeBindings: ['draggable']

  draggable: 'true'

  dragStart: (e) ->
    e.dataTransfer.setData 'text/data', @get 'content'
)