#= require jquery
#= require ui_components/domchange
#= require marked

$(document).on 'uic:domchange', (e) ->
  $(e.target).find('[data-toggle="markdown-readonly"]').each (_, el) ->
    $el = $(el)
    $el.html(marked($el.html().trim()))
    $el.show()
