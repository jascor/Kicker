Kicker.DraggableComponent = Ember.Mixin.create(
  classNames: ['draggableItem']

  classNameBindings: ['isDragging']

  attributeBindings: ['draggable']

  draggable: 'true'

  isDragging: false

  dragStart: (e) ->
    @set 'isDragging', true

  dragEnd: (e) ->
    @set 'isDragging', false

  buildPayload: (title, type) ->
    JSON.stringify(
      title: title
      type: type
    )
)