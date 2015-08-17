$(document).on('uic:domchange', ->
  $('#sidebar').affix offset: top: 0
  $body = $(document.body)
  navHeight = $('.navbar').outerHeight(true) + 10
  $body.scrollspy
    target: '#left-col'
    offset: navHeight
)
