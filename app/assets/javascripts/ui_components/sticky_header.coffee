
setFloatThead = ->
  margin_top = $('.navbar-fixed-top, .navbar-static-top').height()
  $('table[data-toggle=sticky-header]').floatThead
    position: 'fixed'
    top: margin_top

$(document).on 'uic:domchange', ->
  # initialize sticky header
  $(window).one 'scroll', ->
    setFloatThead()

  # destroy sticky header on show/hide alert dom changes
  $('.collapse').on 'show.bs.collapse', (e) ->
    $('table[data-toggle=sticky-header]').floatThead('destroy')

  $('.collapse').on 'hide.bs.collapse', (e) ->
    $('table[data-toggle=sticky-header]').floatThead('destroy')

  $('.collapse').on 'hidden.bs.collapse', (e) ->
    setFloatThead()

  $('.collapse').on 'shown.bs.collapse', (e) ->
    setFloatThead()
