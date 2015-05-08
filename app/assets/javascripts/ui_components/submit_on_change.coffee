$ ->
  $('[data-toggle="submit-on-change"]').change ->
    this.form.submit()
