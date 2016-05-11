$ ->
  $('.toolbar .checkbox input').change ->
    $(this).parents('.checkbox').toggleClass('active', this.checked)

  $('.toolbar .checkbox input').trigger('change')
