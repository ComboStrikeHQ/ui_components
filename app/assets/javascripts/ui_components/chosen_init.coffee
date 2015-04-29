init_group_selectable = (select) ->
  chosen = select.next()
  chosen.on 'click', '.group-result', (e) ->
    target = $(e.target)
    group_name = target.text()
    options = select.find('optgroup[label="' + group_name + '"]').children()
    options.attr('selected', 'selected')
    select.trigger('chosen:updated')

$ ->
  $('[data-toggle="chosen"], .ui-components-select').each ->
    $this = $(this)

    data = $this.data()
    data.search_contains = true
    data.allow_single_deselect = true

    $this.chosen data

    init_group_selectable($this)
