$ ->
  _.each $('.ui-components-modal'), (modal) ->
    $modal = $ modal
    trigger = $($modal.attr('data-trigger'))
    return if trigger.length == 0
    $(trigger).click (e) ->
      url = $modal.attr('data-url')
      if url && url.length > 0
        $modal.find('.modal-body').load url, ->
          $modal.one('shown.bs.modal', (e) -> $modal.trigger('uic:domchange'))
          $modal.modal('show')
      else
        $modal.modal('show')
