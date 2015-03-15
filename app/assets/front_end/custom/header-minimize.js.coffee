resizeHeader = (type) ->
  header = getNodeId 'headerContainer'

  return false unless header

  if type is 'mini'
    addClass header, 'minimized'
  else if type is 'full'
    removeClass header, 'minimized'

window.addEventListener 'scroll', ->
  if @pageYOffset >= 500
    resizeHeader 'mini'
  else
    resizeHeader 'full'