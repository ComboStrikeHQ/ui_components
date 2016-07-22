# frozen_string_literal: true
class CheckboxListCell < UiComponents::Cell
  attribute :form, mandatory: true, description: 'A form object.'
  attribute :name, mandatory: true, description: 'The name attribute.'
  attribute :values, mandatory: true, description: 'The value attributes of the checkboxes.'
  attribute :two_columns, description: 'Whether the checkboxes appear in two columns.'
  attribute :checkbox_class, description: 'extra classes per list-item.'
  attribute :wrapper_class, description: 'extra classes for the ul/wrapper element'

  def show
    content_tag(:ul, box_li_tags, class: css_class)
  end

  private

  def css_class
    "ui-components-checkbox-list #{'two-columns' if options[:two_columns]} #{wrapper_class}"
  end

  def box_li_tags
    safe_join(boxes.map { |box| content_tag(:li, box, class: checkbox_class) }.to_a)
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
