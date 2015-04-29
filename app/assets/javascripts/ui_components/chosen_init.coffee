$ ->
  $('[data-toggle="chosen"]').each ->
    $this = $(this)

    data = $this.data()
    data.search_contains = true
    data.allow_single_deselect = true

    $this.chosen data
