$ ->
  selector = $('[data-toggle="markdown"]')
  selector.change ->
    $this = $(this)
    target = $this.data('target')
    preview = marked($this.val())
    $(target).html(preview)

  selector.trigger('change')
