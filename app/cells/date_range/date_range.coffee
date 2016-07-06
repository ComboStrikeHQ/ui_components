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
    opens: 'right',
    format: 'YYYY-MM-DD',
    submitOnChange: false
  }

  $(e.target).find('.ui-components-date-range').each (_i, el) ->
    $el = $(el)
    $form = $el.parents('form')
    $start_input = $($el.data().start)
    $end_input = $($el.data().end)

    start_date = _.find [$el.data('startDate'), $start_input.val(), yesterday],
                        (val) -> val && val.toString().length > 0
    end_date = _.find [$el.data('endDate'), $end_input.val(), yesterday],
                      (val) -> val && val.toString().length > 0
    opens = _.find [$el.data('opens')]

    options = _.extend({},
      defaults,
      _.pick($el.data(), ['dateLimit', 'ranges', 'submitOnChange']),
      { startDate: start_date, endDate: end_date, opens: opens })

    options.ranges = _.mapObject(options.ranges, (v, k) -> _.map(v, (v) -> moment(v)))
    options.startDate = moment(options.startDate)
    options.endDate = moment(options.endDate)

    reset = (start, end) ->
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

    callback = (start, end) ->
      reset(start, end)

      if ($el.data().submitOnChange)
        $form.submit()

    $el.daterangepicker(options, callback)

    reset(options.startDate, options.endDate)
