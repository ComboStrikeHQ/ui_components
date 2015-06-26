$(document).on 'uic:domchange', ->
  margin_top = $('.navbar-fixed-top, .navbar-static-top').height()
  $('table[data-toggle=sticky-header]').floatThead
    useAbsolutePositioning: false
    scrollingTop: margin_top
