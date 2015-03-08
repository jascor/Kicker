unless String.prototype.format
  String.prototype.format = ->
    args = arguments

    @replace /{(\d+)}/g, (match, number) ->
      if typeof args[number] isnt 'undefined' then args[number] else match