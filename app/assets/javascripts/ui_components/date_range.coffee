$ ->
  today = -> moment().startOf('day')
  yesterday = today().subtract(1, 'days')
  ranges = {
    'Yesterday': [yesterday, yesterday],
    'Last 7 Days': [today().subtract(7, 'days'), yesterday],
    'Last 14 Days': [today().subtract(14, 'days'), yesterday],
    'Last 30 Days': [today().subtract(30, 'days'), yesterday],
    'Month to Date': [
      today().startOf('month'),
      today()
    ],
    'Last Month': [
      today().subtract(1, 'month').startOf('month'),
      today().subtract(1, 'month').endOf('month').startOf('day')
    ]
  }

  default_date = (date) ->
    return yesterday if date == ''
    moment(date)

  $('.ui-components-date-range').each ->
    $this = $(this)
    $start_input = $($this.data().start)
    $end_input = $($this.data().end)

    callback = (start, end) ->
      end.startOf('day')

      $start_input.val(start.format('YYYY-MM-DD'))
      $end_input.val(end.format('YYYY-MM-DD'))

      label = 'Custom Range'
      for range_label, range of ranges
        if range[0].diff(start) == 0 and range[1].diff(end) == 0
          label = range_label

      $this.html(
        label + ' (' + start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD') + ')'
      )

    $this.daterangepicker(
      ranges: ranges,
      startDate: default_date($start_input.val()),
      endDate: default_date($end_input.val()),
      opens: 'right',
      format: 'YYYY-MM-DD',
      callback
    )

    callback(default_date($start_input.val()), default_date($end_input.val()))
