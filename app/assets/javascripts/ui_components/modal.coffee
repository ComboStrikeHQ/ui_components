$ ->
  _.each $('.ui-components-modal'), (modal) ->
    $modal = $ modal
    selector = $($modal.attr('data-trigger'))
    return if selector.length == 0
    $(selector).click (e) ->
      $modal.modal('show')
