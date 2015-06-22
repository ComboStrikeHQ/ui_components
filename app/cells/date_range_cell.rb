class DateRangeCell < FormCellBase
  def show
    [
      date_field(:from),
      date_field(:to),
      select_div
    ].join
  end

  private

  def date_field(type)
    options[:form].text_field(
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
