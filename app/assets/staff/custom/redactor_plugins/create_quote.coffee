root = exports ? this

if not root.RedactorPlugins then root.RedactorPlugins = {}

root.RedactorPlugins.createQuote = ->
  getTemplate: ->
    String() +
    '<section id="redactor-modal-create-quote">' +
    '<label>Citation (who is being quoted?)</label>' +
    '<input type="text" name="quoteCitation" id="redacPluginCreateQuoteCite">' +
    '<label>Quote</label>' +
    '<textarea id="redacPlguinCreateQuoteContents" class="cantResize"></textarea>' +
    '<label>Quote Type (size)</label>' +
    '<select id="redacPluginCreateQuoteChooseType">' +
    '<option value="full">Full Width</option>' +
    '<option value="left">Align to Left (part of article)</option>' +
    '<option value="right">Align to Right (part of article)</option>' +
    '</select>' +
    '</section>'

  init: ->
    button = @button.add 'create-quote', 'Create Quote'
    @button.setAwesome 'create-quote', 'fa-quote-left'
    @button.addCallback button, @createQuote.show

  show: ->
    @modal.addTemplate 'create-quote', @createQuote.getTemplate()
    @modal.load 'create-quote', 'Create Quote', 600
    @modal.createCancelButton()

    button = @modal.createActionButton 'Create'
    button.on 'click', @createQuote.insert

    @selection.save()
    @modal.show()

    $('#redacPlguinCreateQuoteContents').focus()

  insert: ->
    html = $('#redacPlguinCreateQuoteContents').val()

    @modal.close()
    @selection.restore()

    @insert.html html

    @code.sync()