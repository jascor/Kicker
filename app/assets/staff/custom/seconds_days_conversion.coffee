differenceBetweenSecondsInDays = (largeSeconds, smallSeconds) ->
  Math.floor (largeSeconds - smallSeconds) * 1.15741e-5

window.differenceBetweenSecondsInDays = differenceBetweenSecondsInDays