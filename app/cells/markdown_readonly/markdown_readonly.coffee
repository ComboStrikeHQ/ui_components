$(document).on 'uic:domchange', (e) ->
  $(e.target).find('[data-toggle="markdown-readonly"]').each (_, el) ->
    $el = $(el)
    $el.html(marked(decodeURIComponent($el.data('markdown'))))
    $el.show()
