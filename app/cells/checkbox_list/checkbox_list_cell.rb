class CheckboxListCell < UiComponents::Cell
  attribute :form, mandatory: true, description: 'A form object.'
  attribute :name, mandatory: true, description: 'The name attribute.'
  attribute :values, mandatory: true, description: 'The value attributes of the checkboxes.'
  attribute :two_columns, description: 'Whether the checkboxes appear in two columns.'

  def show
    content_tag(:ul, box_li_tags, class: css_class)
  end

  private

  def css_class
    "ui-components-checkbox-list #{'two-columns' if options[:two_columns]}"
  end

  def box_li_tags
    boxes.map do |box|
      content_tag(:li, box)
    end.join.html_safe
  end

  def boxes
    options[:values].map do |value|
      options[:form].check_box(options[:name], { multiple: true, label: label(value) }, value, nil)
    end
  end

  def label(key)
    controller.t(".#{options[:name]}.#{key}")
  end
end
