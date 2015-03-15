getNodeId = (id) ->
  document.getElementById id

addClass = (node, className) ->
  node.classList.add className

addClasses = (node, classes) ->
  return null unless typeof classes.constructor is Array

  i = 0
  while i < classes.length
    addClass node, classes[i]

removeClass = (node, className) ->
  node.classList.remove className

window.getNodeId = getNodeId
window.addClass = addClass
window.addClasses = addClasses
window.removeClass = removeClass