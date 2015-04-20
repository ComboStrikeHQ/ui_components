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
    model.text_field(
      "#{options[:name]}_#{type}",
      id: "#{id}_#{type}",
      skip_label: true,
      style: 'display: none'
    )
  end

  def select_div
    model.send(:form_group_builder, :daterange, label: label) do
      content_tag(
        :div,
        '',
        class: 'ui-components-date-range form-control',
        data: { start: "##{id}_from", end: "##{id}_to" }
      )
    end
  end

  def id
    @id ||= SecureRandom.hex(8)
  end
end
