# Selects all options of a multi-select box belonging to a optgroup, when
# clicking on the optgroup label.
#init_group_selectable = (select) ->
#  chosen = select.next()
#  chosen.on 'click', '.group-result', (e) ->
#    target = $(e.target)
#    group_name = target.text()
#    options = select.find('optgroup[label="' + group_name + '"]').children()
#    options.attr('selected', 'selected')
#    select.trigger('chosen:updated')
#
#$ ->
#  $('.ui-components-select').each ->
#    $this = $(this)
#
#    data = $this.data()
#    data.search_contains = true
#
#    $this.chosen data
#
#    # Append help-block to parent .form-group element
#    $formGroup = $this.closest('.form-group')
#    $formGroup.css('position', 'relative')
#    $helpBlock = $formGroup.find('.help-block')
#    $helpBlock.css('position', 'absolute')
#    $helpBlock.css('top', '1.6em')
#    $helpBlock.css('left', '3em')
#
#    init_group_selectable($this)
#
#    if data.remoteOptions
#      $this.ajaxChosen
#        type: 'GET'
#        url: data.remoteOptions
#        dataType: 'json'
