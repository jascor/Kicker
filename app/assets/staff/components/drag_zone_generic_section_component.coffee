Kicker.DragZoneGenericSectionComponent = Ember.Component.extend(Ember.MutableArray,
  layoutName: 'components/drag_zone_generic_section'

  classNames: ['organizeDragZone', 'genericSection']

  actions:
    ###
      @todo This is probably really bad...try and place this into a mixin for all components.
    ###
    droppedItemCallback: (data) ->
      @sendAction 'dropped', data
)