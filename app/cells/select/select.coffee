#= require jquery
#= require chosen
#= require ajax-chosen

# Selects all options of a multi-select box belonging to a optgroup, when
# clicking on the optgroup label.
init_group_selectable = (select) ->
  chosen = select.next()
  chosen.on 'click', '.group-result', (e) ->
    target = $(e.target)
    group_name = target.text()
    options = select.find('optgroup[label="' + group_name + '"]').children()
    options.attr('selected', 'selected')
    select.trigger('chosen:updated')

$ ->
  $('.ui-components-select').each ->
    $this = $(this)

    data = $this.data()
    data.search_contains = true
    data.allow_single_deselect = true

    $this.chosen data

    init_group_selectable($this)

    if data.remoteOptions
      $this.ajaxChosen
        type: 'GET'
        url: data.remoteOptions
        dataType: 'json'
