$ ->
  $('.toolbar .checkbox input').change ->
    $(this).parents('li.btn').toggleClass('active', this.checked)

  $('.toolbar .checkbox input').trigger('change')
