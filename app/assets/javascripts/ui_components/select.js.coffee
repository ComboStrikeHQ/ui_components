$ ->
  $('.ui-components-select').each ->
    $this = $(this)

    data = $this.data()
    data.search_contains = true

    $this.chosen data

    # Append help-block to parent .form-group element
    $formGroup = $this.closest('.form-group')
    $formGroup.css('position', 'relative')
    $helpBlock = $formGroup.find('.help-block')
    $helpBlock.css('position', 'absolute')
    $helpBlock.css('top', '1.6em')
    $helpBlock.css('left', '3em')

