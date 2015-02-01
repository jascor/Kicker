Kicker.DraggableZoneComponent = Ember.Component.extend(
  layoutName: 'staff/components/draggable_zone'

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
    data = e.dataTransfer.getData 'text/data'
    @sendAction 'dropped', data
)