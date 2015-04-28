$ ->
  $('[data-toggle="chosen"]').each ->
    $this = $(this)

    data = $this.data()
    data.search_contains = true

    $this.chosen data
