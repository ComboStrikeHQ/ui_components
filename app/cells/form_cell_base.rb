# frozen_string_literal: true

class FormCellBase < UiComponents::Cell
  include ActionView::Helpers::FormOptionsHelper

  private

  def name
    options.fetch(:name)
  end

  def name_param
    "#{form.object_name}_#{name}".underscore
  end

  def label
    options[:label]
  end

  def form
    options.fetch(:form)
  end

  def t(key)
    I18n.t("ui_components.#{self.class.to_s.underscore}.#{key}")
  end
end
