#= require jquery
#= require chosen/chosen.jquery
#= require ajax-chosen/lib/ajax-chosen
#= require underscore

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

    data = transform_keys $this.data(), underscore
    data.search_contains = true
    $this.chosen data

    init_group_selectable($this)

    if data.remote_options
      $this.ajaxChosen
        type: 'GET'
        url: data.remote_options
        dataType: 'json'

underscore = (str) -> str.replace /[A-Z]/g, (m) -> '_' + m.toLowerCase()

transform_keys = (obj, f) -> _.object _.map obj, (v, k) -> [f(k), v]
