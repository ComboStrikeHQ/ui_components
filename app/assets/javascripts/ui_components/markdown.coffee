$ ->
  selector = $('[data-toggle="markdown"]')
  selector.change ->
    $this = $(this)
    target = $this.data('target')
    preview = marked($this.val())
    $(target).html(preview)

  selector.trigger('change')

renderMarkdown = (el) ->
  $el = $(el)

  if $el.attr('data-toggle') != 'markdown-readonly'
    $el = $el.find('[data-toggle="markdown-readonly"]')

  $el.html(marked($el.html().trim()))
  $el.show()

$ ->
  $('[data-toggle="markdown-readonly"]').each (_, el) ->
    renderMarkdown(el)

$(document).on 'shown.bs.modal', (e) ->
  renderMarkdown(e.target)
