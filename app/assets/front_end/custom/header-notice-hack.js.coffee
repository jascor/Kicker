###
  The implemented "notice" system, essentially a way for us to place
  a (client closeable) banner with some sort of message at the top
  of all pages, requires a little hack to get other elements of the
  page to be positioned correctly.

  Since the banner contaning the notice has no fixed height and the
  headerContainer node is fixed, we can't position the rest of the
  page below it. Only the actual header's height is fixed.

  By default, everything "below" the headerContainer is placed under
  the actual header (fixed height). When the "banner notice" is
  introduced to the page, it introduces extra height we haven't
  accounted for and covers a part of the (top of) the
  contentContainer.

  To fix this, we'll use JavaScript is added an "invisible" div
  that will account for the height of the banner to the body
  (above the contentContainer). When a client resizes their
  browser or scrolls, we check to make sure the fake div and
  banner are still of the same height and fix it if they aren't.

  I'm sure there's some CSS solution to this, but as of now, I
  can't think of it.

  @todo Migrate to fully CSS-based solution
###

fixPagePositionWithNoticeBanner = (noticeBanner) ->
  unless noticeBanner.offsetHeight > 0
    return false

  positionHack = document.createElement 'div'
  positionHack.id = 'noticePositionHack'
  positionHack.style.height = "#{noticeBanner.offsetHeight}px"

  document.body.insertBefore positionHack, getNodeId 'headerContainer'

maintainPagePositionNoticeBannerHack = (noticeBannerHeight) ->
  positionHack = getNodeId 'noticePositionHack'

  unless positionHack.offsetHeight is noticeBannerHeight
    positionHack.style.height = "#{noticeBannerHeight}px"

removePagePositionNoticeBannerHack = ->
  positionHack = getNodeId 'noticePositionHack'

  if positionHack
    positionHack.parentNode.removeChild positionHack

# @todo Use cookie to remember closing of notices
closeNoticeBanner = (noticeBanner) ->
  noticeBanner.parentNode.removeChild noticeBanner
  removePagePositionNoticeBannerHack()

notice = getNodeId 'notice'
closeNotice = getNodeId 'closeDelNotice'

if notice and closeNotice
  closeNotice.addEventListener 'click', (e) ->
    (if e.preventDefault then e.preventDefault() else @returnValue = false)

    closeNoticeBanner notice
    notice = 0

  fixPagePositionWithNoticeBanner notice

  window.addEventListener 'scroll', ->
    return false unless notice
    maintainPagePositionNoticeBannerHack notice.offsetHeight

  window.addEventListener 'resize', ->
    return false unless notice
    maintainPagePositionNoticeBannerHack notice.offsetHeight