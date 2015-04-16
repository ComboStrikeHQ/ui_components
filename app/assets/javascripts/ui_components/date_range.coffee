$ ->
  midnight = moment().startOf('day')
  ranges = {
    'Yesterday': [moment(midnight).subtract(1, 'days'), moment(midnight).subtract(1, 'days')],
    'Last 7 Days': [moment(midnight).subtract(7, 'days'), moment(midnight).subtract(1, 'days')],
    'Last 14 Days': [moment(midnight).subtract(14, 'days'), moment(midnight).subtract(1, 'days')],
    'Last 30 Days': [moment(midnight).subtract(30, 'days'), moment(midnight).subtract(1, 'days')],
    'Month to Date': [
      moment(midnight).startOf('month'),
      moment(midnight).endOf('month').startOf('day')
    ],
    'Last Month': [
      moment(midnight).subtract(1, 'month').startOf('month'),
      moment(midnight).subtract(1, 'month').endOf('month').startOf('day')
    ]
  }

  default_date = (date) ->
    return moment(midnight).subtract(1, 'days') if date == ''
    moment(date)

  $('.ui-components-date-range').each ->
    $this = $(this)
    $start = $($this.data().start) || midnight
    $end = $($this.data().end) || midnight

    callback = (start, end) ->
      end.startOf('day')

      $start.val(start.format('YYYY-MM-DD'))
      $end.val(end.format('YYYY-MM-DD'))

      label = 'Custom Range'
      for range_label, range of ranges
        if range[0].diff(start) == 0 and range[1].diff(end) == 0
          label = range_label

      $this.html(
        label + ' (' + start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD') + ')'
      )

    $this.daterangepicker(
      ranges: ranges,
      startDate: $start.val(),
      endDate: $end.val(),
      opens: 'right',
      format: 'YYYY-MM-DD',
      callback
    )

    callback(default_date($start.val()), default_date($end.val()))
