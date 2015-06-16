$ ->
  _.each $('.ui-components-modal'), (modal) ->
    $modal = $ modal
    selector = $($modal.attr('data-trigger'))
    return if selector.length == 0
    $(selector).click (e) ->
      url = $modal.attr('data-url')
      if url && url.length > 0
        $modal.find('.modal-body').load url, ->
          $modal.modal('show')
      else
        $modal.modal('show')
