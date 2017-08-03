# frozen_string_literal: true

class DateRangeCell < FormCellBase
  attribute :form, mandatory: true, description: 'A form object.'
  attribute :name, mandatory: true, description: 'The name attribute.'
  attribute :label, description: 'A label.'
  attribute :ranges, description: 'A hash of selectable ranges of the form ' \
                                  '`{ label => [from_date, to_date] }`'
  attribute :date_limit, description: 'The maximum span between the selected ' \
    'start and end dates. Can have any property you can add to a ' \
    '[moment](http://momentjs.com/docs/#/durations/creating/) object (i.e. ' \
    'days, months)'
  attribute :start_date, description: 'Default start date'
  attribute :end_date, description: 'Default end date'
  attribute :opens, description: 'Direction in which the dropdown opens. ' \
    "Accepts: 'right' (default), 'left', 'center'"
  attribute :submit_on_change, description: 'Whether the enclosing form should be ' \
    'automatically submitted on value change'
  attribute :min_date, description: 'The earliest date a user may select'
  attribute :max_date, description: 'The latest date a user may select'

  def show
    [
      date_field(:from),
      date_field(:to),
      select_div
    ].join
  end

  private

  def date_field(type)
    options[:form].hidden_field(
      "#{options[:name]}_#{type}",
      id: "#{id}_#{type}",
      skip_label: true,
      style: 'display: none'
    )
  end

  def select_div
    options[:form].form_group(:daterange, label: label) do
      content_tag(:div, '', class: 'ui-components-date-range form-control', data: data)
    end
  end

  def data
    options.slice(:ranges, :date_limit, :opens, :submit_on_change).merge(dates).merge(
      start: "##{id}_from", end: "##{id}_to"
    )
  end

  def dates
    %i[start_date end_date min_date max_date].each_with_object({}) do |attribute, hash|
      hash[attribute] = public_send(attribute).to_s.presence
    end
  end

  def id
    "date_range_#{name_param}"
  end

  def label
    { text: options[:label] } if options[:label]
  end
end
