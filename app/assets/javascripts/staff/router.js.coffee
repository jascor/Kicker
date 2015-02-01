Kicker.Router.map ->
  @resource 'articles', ->
    @route 'new'

  @resource 'article', path: '/article/:article_id', ->
    @route 'edit'
    @route 'preview'

  @resource 'sections', ->
    @route 'new'

  @resource 'section', path: '/section', ->
    @route 'organize', path: '/:section_id/organize'
    @route 'edit', path: '/section_id/edit'
    @route 'preview', path: '/section_id/preview'