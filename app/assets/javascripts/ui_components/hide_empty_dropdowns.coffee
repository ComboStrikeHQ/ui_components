$ ->
  $('.dropdown').each (i, dropdown) ->
    if $(dropdown).find('ul li:not(.divider)').length == 0
      $(dropdown).find('a').hide()
