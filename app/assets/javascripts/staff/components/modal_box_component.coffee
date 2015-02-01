Kicker.ModalBoxComponent = Ember.Component.extend(
  layoutName: 'staff/components/modal_box'

  classNames: ['modalBoxContainer']

  isCloseableByOverlayClick: false

  isModalActive: false

  init: ->
    @_super()

  didInsertElement: ->

  actions:
    toggleVisibility: ->
      unless @isModalActive then return false
      @set 'isModalActive', (if @isModalActive then false else true)

    closeOnOverlayClick: ->
      if @isCloseableByOverlayClick then @sendAction 'onModalClose'
)