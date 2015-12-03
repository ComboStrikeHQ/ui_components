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

  def show
    [
      date_field(:from),
      date_field(:to),
      select_div
    ].join
  end

  private

  def date_field(type)
    options[:form].hidden_field("#{options[:name]}_#{type}", id: "#{id}_#{type}")
  end

  def select_div
    options[:form].form_group(:daterange, label: label) do
      content_tag(:div, '', class: 'ui-components-date-range form-control', data: data)
    end
  end

  def data
    options.slice(:ranges, :date_limit)
      .merge(start: "##{id}_from", end: "##{id}_to")
  end

  def id
    "date_range_#{name_param}"
  end

  def label
    { text: options[:label] } if options[:label]
  end
end
