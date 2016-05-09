$ ->
  # all checked checkboxes display as active
  $(".toolbar .checkbox input[type='checkbox']:checked").parents('.checkbox').addClass('active')

  # checking/unchecking checkbox displays as active/inactive
  $(".toolbar .checkbox input[type='checkbox']").change ->
    if @checked
      $(this).parents('.checkbox').addClass('active')
    else
      $(this).parents('.checkbox').removeClass('active')
