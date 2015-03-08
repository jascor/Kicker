Kicker.DraggableZone = Ember.Mixin.create(
  classNames: ['draggableZone']

  classNameBindings: ['dragClass']

  dragClass: 'deactivated'

  dragLeave: (e) ->
    e.preventDefault()
    @set 'dragClass', 'deactivated'

  dragOver: (e) ->
    e.preventDefault()
    @set 'dragClass', 'activated'

  drop: (e) ->
    @set 'dragClass', 'deactivated'

    data = e.dataTransfer.getData 'payload'
    callback = @get 'dropped'

    if callback then @sendAction 'dropped', data
)