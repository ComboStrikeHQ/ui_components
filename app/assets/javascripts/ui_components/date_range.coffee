$(document).on 'uic:domchange', (e) ->
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

  defaults = {
    ranges: ranges,
    startDate: yesterday,
    endDate: yesterday,
    opens: 'right',
    format: 'YYYY-MM-DD',
  }

  $(e.target).find('.ui-components-date-range').each (_i, el) ->
    $el = $(el)
    $start_input = $($el.data().start)
    $end_input = $($el.data().end)

    start_date = _.find [$start_input.val(), yesterday],
                        (val) -> val && val.toString().length > 0
    end_date = _.find [$end_input.val(), yesterday],
                      (val) -> val && val.toString().length > 0

    start_date = moment(start_date)
    end_date = moment(end_date)

    options = {}
    _.extend(options, defaults)
    _.extend(options, _.pick($el.data(), ['dateLimit', 'ranges']))
    _.extend(options, { startDate: start_date, endDate: end_date })
    options.ranges = _.mapObject(options.ranges, (v, k) -> _.map(v, (v) -> moment(v)))

    callback = (start, end) ->
      end.startOf('day')

      $start_input.val(start.format('YYYY-MM-DD'))
      $end_input.val(end.format('YYYY-MM-DD'))

      label = 'Custom Range'
      for range_label, range of options.ranges
        if range[0].diff(start) == 0 and range[1].diff(end) == 0
          label = range_label

      $el.html(
        label + ' (' + start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD') + ')'
      )

    $el.daterangepicker(options, callback)

    callback(options.startDate, options.endDate)
