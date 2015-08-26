setFloatThead = ->
  margin_top = $('.navbar-fixed-top, .navbar-static-top').height()
  $('table[data-toggle=sticky-header]').floatThead
    useAbsolutePositioning: false
    scrollingTop: margin_top

# workaround for race condition between chosen and floatThead
$(document).on 'uic:domchange', ->
  window.setTimeout setFloatThead, 200
